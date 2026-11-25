
# Index cohort: device (SNOMED)
# - UDI and procedure availability ----
logMessage("Index cohort: device (SNOMED)")
logMessage("- UDI and procedure availability")
for(pref in procedures_to_run) {
  results[[paste0(pref,"_availability")]] <- cdm[[paste0(pref,"_devices")]] |>
    summariseCharacteristics(
      cohortIntersectFlag = list(
        "UDI" = list(
          targetCohortTable = paste0(pref,"_udi"),
          window = c(0,0)
        ),
        "Procedures (at index date)" = list(
          targetCohortTable = paste0(pref,"_procedures"),
          window = c(0,0)
        ),
        "Procedures (prior week)" =  list(
          targetCohortTable = paste0(pref,"_procedures"),
          window = c(-7,-1)
        )
      )
    )
}

# Index cohort: procedure (SNOMED) ----
logMessage("Index cohort: procedure")
for(pref in procedures_to_run) {
  results[[paste0(pref,"_completeness")]] <- cdm[[paste0(pref,"_procedures")]] |>
    summariseCharacteristics(
      cohortIntersectFlag = list(
        "UDI" = list(
          targetCohortTable = paste0(pref,"_udi"),
          window = c(0,0)
        ),
        "Devices" = list(
          targetCohortTable = paste0(pref,"_devices"),
          window = c(0,0)
        )
      )
    )
}




