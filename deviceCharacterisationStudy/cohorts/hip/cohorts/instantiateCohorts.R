codes <- importCodelist(here::here("cohorts","hip", "cohorts", "codelists"))
udi_files <- list.files(path = here::here("cohorts","hip","cohorts", "udi"),
                        pattern = "\\.csv$", full.names = TRUE)
udi <- udi_files |>
  set_names(tools::file_path_sans_ext(basename(udi_files))) |>
  purrr::map(~ readr::read_csv(.x, col_types = vroom::cols(.default = vroom::col_character())) |> dplyr::pull("udi"))

# diagnoses -----
diag <- importCodelist(here::here("cohorts","hip", "cohorts", "codelists", "comorbidities"))
cdm[["hip_diagnoses"]] <- conceptCohort(cdm,
                                        conceptSet = diag,
                                        name = "hip_diagnoses",
                                        exit = "event_start_date")

# procedures -----
cdm[["hip_procedures"]] <- conceptCohort(cdm,
                                         conceptSet = codes[str_detect(names(codes), "hemi|hip_replacement|hip_revision")],
                                         name = "hip_procedures",
                                         exit = "event_start_date")
# procedures -----
cdm[["hip_complications"]] <- conceptCohort(cdm,
                                         conceptSet = codes["vte"],
                                         name = "hip_complications",
                                         exit = "event_start_date")


# device (index event)  -----
cdm[["hip_devices"]] <- conceptCohort(cdm,
                                      conceptSet = codes[str_detect(names(codes), "femoral_head|femur_prosthesis")],
                                      name = "hip_devices",
                                      exit = "event_start_date")


# udi  -----
cdm$hip_udi <- customCohort(cdm,
                            table = "device_exposure",
                            field = "unique_device_id",
                            values = udi,
                            name = "hip_udi")

# bind -----
cdm <- bind(cdm$hip_diagnoses,
            cdm$hip_procedures,
            cdm$hip_complications,
            cdm$hip_devices,
            cdm$hip_udi,
            name = "hip")
attr(cdm$hip, "cohort_set") <- attr(cdm$hip, "cohort_set") |>
  mutate(group = "hip")
