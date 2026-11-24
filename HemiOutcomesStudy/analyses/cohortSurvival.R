results[["surv"]] <- estimateSingleEventSurvival(cdm = cdm,
                                                targetCohortTable = "hemi",
                                                outcomeCohortTable = "stroke",
                                                followUpDays = 120,
                                                eventGap = 30)


