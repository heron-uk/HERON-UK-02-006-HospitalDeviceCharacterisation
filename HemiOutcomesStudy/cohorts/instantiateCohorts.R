
codes <- importCodelist(here::here("codelist"))

# hip fx -----
cdm$hip_fx  <- conceptCohort(cdm = cdm,
                             conceptSet = codes["hip_fx"],
                             name = "hip_fx",
                             exit = "event_start_date")

# hemi ----
cdm$hemi <- conceptCohort(cdm = cdm,
                          conceptSet = codes["hemi"],
                          name = "hemi",
                          exit = "event_start_date")
cdm$hemi <- cdm$hemi |>
  requireIsFirstEntry() |>
  requireCohortIntersect(targetCohortTable = "hip_fx",
                         window = c(-3, 0)) |>
  requirePriorObservation(365) |>
  requireAge(c(18, Inf))


# stroke -----
cdm$stroke  <- conceptCohort(cdm = cdm,
                             conceptSet = codes[stringr::str_detect(names(codes), "stroke")],
                             name = "stroke",
                             exit = "event_start_date")

if(stringr::str_detect(tolower(cdmName(cdm)),"aurum")){
  cdm$stroke_hospital  <- conceptCohort(cdm = cdm,
                               conceptSet = codes[stringr::str_detect(names(codes), "stroke")],
                               name = "stroke_hospital",
                               exit = "event_start_date",
                               typeConceptId = 32829)
  attr(cdm$stroke_hospital, "settings") <- attr(cdm$stroke_hospital, "settings") |>
    mutate(cohort_name = paste0(cohort_name, "_in_hospital"))
  cdm <- bind(cdm$stroke,
              cdm$stroke_hospital,
              name = "stroke")
  }
