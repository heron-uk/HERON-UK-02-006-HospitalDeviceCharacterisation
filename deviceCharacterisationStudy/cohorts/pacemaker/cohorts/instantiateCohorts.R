
codes <- omopgenerics::importCodelist(here::here("cohorts","pacemaker", "cohorts", "codelists"))
udi_files <- list.files(path = here::here("cohorts","pacemaker","cohorts", "udi"),
                        pattern = "\\.csv$", full.names = TRUE)
udi <- udi_files |>
  set_names(tools::file_path_sans_ext(basename(udi_files))) |>
  purrr::map(~ readr::read_csv(.x, col_types = cols(.default = col_character())) |> pull("udi"))

# diagnoses -----
diag <- c(
  CodelistGenerator::unionCodelists(
    omopgenerics::importCodelist(here::here("cohorts","pacemaker", "cohorts", "codelists", "other_comorbidities")),
    keepOriginal = TRUE,
    newCodelistName = "other_comorbidities"
  ),
  CodelistGenerator::unionCodelists(
    omopgenerics::importCodelist(here::here("cohorts","pacemaker", "cohorts", "codelists", "neuromuscular_disorders")),
    keepOriginal = TRUE,
    newCodelistName = "neuromuscular_disorders"
  ),
  CodelistGenerator::unionCodelists(
    omopgenerics::importCodelist(here::here("cohorts","pacemaker", "cohorts", "codelists", "genetic_and_chromosomal_syndromes")),
    keepOriginal = TRUE,
    newCodelistName = "genetic_and_chromosomal_syndromes"
  ),
  CodelistGenerator::unionCodelists(
    omopgenerics::importCodelist(here::here("cohorts","pacemaker", "cohorts", "codelists", "cardiac_construction_disorders_and_arrhythmias")),
    keepOriginal = TRUE,
    newCodelistName = "cardiac_construction_disorders_and_arrhythmias"
  )
)

cdm$pacemaker_diagnoses <- conceptCohort(cdm,
                                         conceptSet = diag,
                                         name = "pacemaker_diagnoses",
                                         exit = "event_start_date")

# procedures -----
cdm$pacemaker_procedures <- conceptCohort(cdm,
                                          conceptSet = codes[names(codes) %in% c("pacemaker_implantation_unspecified",
                                                                                 "pacemaker_implantation_single",
                                                                                 "pacemaker_implantation_dual",
                                                                                 "pacemaker_replacement", "pacemaker_repair",
                                                                                 "pacemaker_removal", "pacemaker_relocation")],
                                          name = "pacemaker_procedures",
                                          exit = "event_start_date")

# Complications
cdm$pacemaker_complications <- conceptCohort(cdm,
                                   conceptSet = codes[names(codes) %in% c("endocarditis")],
                                   name = "pacemaker_complications",
                                   exit = "event_start_date")

# device (index event)  -----
cdm$pacemaker_devices <- conceptCohort(cdm,
                                       conceptSet = codes[names(codes) %in% c("pacemaker", "pacemaker_dual", "pacemaker_single")],
                                       name = "pacemaker_devices",
                                       exit = "event_start_date")

# udi  -----
cdm$pacemaker_udi <- customCohort(cdm,
                                  table = "device_exposure",
                                  field = "unique_device_id",
                                  values = udi,
                                  name = "pacemaker_udi")
# bind -----
cdm <- bind(cdm$pacemaker_diagnoses,
            cdm$pacemaker_procedures,
            cdm$pacemaker_complications,
            cdm$pacemaker_devices,
            cdm$pacemaker_udi,
            name = "pacemaker")
attr(cdm$pacemaker, "cohort_set") <- attr(cdm$pacemaker, "cohort_set") |>
  mutate(group = "pacemaker")
