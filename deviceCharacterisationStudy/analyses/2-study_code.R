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
          window = c(-3,3)
        ),
        "Comorbidities" = list(
          targetCohortTable = paste0(pref, "_diagnoses"),
          window = c(-Inf, 0)
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
        "UDI (sensitivity)" = list(
          targetCohortTable = paste0(pref,"_udi"),
          window = c(-3,3)
        ),
        "Devices" = list(
          targetCohortTable = paste0(pref,"_devices"),
          window = c(0,0)
        ),
        "Devices (sensitivity)" = list(
          targetCohortTable = paste0(pref,"_devices"),
          window = c(-3,3)
        ),
        "Comorbidities" = list(
          targetCohortTable = paste0(pref, "_diagnoses"),
          window = c(-Inf, 0)
        )
      )
    )
}


# Index cohort: procedure (SNOMED) ----
logMessage("Index cohort: survival")
for(pref in c("pacemaker", "hip")) {

  if(pref == "pacemaker") {
    index <- c("pacemaker_implantation_unspecified", "pacemaker_implantation_single", "pacemaker_implantation_dual")
    outcomes <- c("pacemaker_relocation", "pacemaker_removal", "pacemaker_repair", "pacemaker_replacement", "endocarditis")
  }

  if(pref == "hip") {
    index <- c("hemi_cemented", "hemi_uncemented", "hemi_unspecified")
    outcomes <- c("vte", "hemi_revision", "hemi_uncemented_revision", "hemi_cemented_revision")
  }

  for(i in index){
    results[[paste0(pref,"_survival_",i)]] <- cdm |>
      estimateSingleEventSurvival(targetCohortTable = paste0(pref,"_procedures"),
                                  targetCohortId = i,
                                  outcomeCohortId = outcomes,
                                  outcomeCohortTable = pref,
                                  outcomeWashout = Inf)
  }
}



