codes <- importCodelistWithDetails(here::here("cohorts","lens", "cohorts", "codelists"))
udi_files <- list.files(path = here::here("cohorts","lens","cohorts", "udi"),
                        pattern = "\\.csv$", full.names = TRUE)
udi <- udi_files |>
  set_names(tools::file_path_sans_ext(basename(udi_files))) |>
  purrr::map(~ readr::read_csv(.x, col_types = cols(.default = col_character())) |> pull("udi"))

# diagnoses -----
cdm[["lens_diagnoses"]] <- conceptCohort(cdm,
                                        conceptSet = codes[c("cataract")],
                                        name = "lens_diagnoses",
                                        exit = "event_start_date")

# procedures -----
cdm[["lens_procedures"]] <- conceptCohort(cdm,
                                         conceptSet = codes[str_detect(names(codes), "lens_implantation")],
                                         name = "lens_procedures",
                                         exit = "event_start_date")

# device (index event)  -----
cdm[["lens_devices"]] <- conceptCohort(cdm,
                                      conceptSet = codes[names(codes) %in% c("lens", "lens_anterior", "lens_posterior")],
                                      name = "lens_devices",
                                      exit = "event_start_date")

# udi  -----
cdm[["lens_udi"]] <- customCohort(cdm,
                                      table = "device_exposure",
                                      field = "unique_device_id",
                                      values = udi,
                                      name = "lens_udi")

# bind -----
cdm <- bind(cdm$lens_diagnoses,
            cdm$lens_procedures,
            cdm$lens_devices,
            cdm$lens_udi,
            name = "lens")
attr(cdm$lens, "cohort_set") <- attr(cdm$lens, "cohort_set") |>
  mutate(group = "lens")
