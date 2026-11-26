# shiny is prepared to work with this resultList:
resultList <- list(
  summarise_omop_snapshot = list(result_type = "summarise_omop_snapshot"),
  summarise_observation_period = list(result_type = "summarise_observation_period"),
  summarise_cohort_count = list(result_type = "summarise_cohort_count"),
  summarise_characteristics = list(result_type = "summarise_characteristics"),
  survival = list(result_type = c("survival_summary", "survival_estimates", "survival_events", "survival_attrition")),
  summarise_log_file = list(result_type = "summarise_log_file")
)

source(file.path(getwd(), "functions.R"))

result <- omopgenerics::importSummarisedResult(file.path(getwd(), "rawData"))
data <- prepareResult(result, resultList)
values <- getValues(result, resultList)

values$summarise_cohort_count_cohort_name <- c("lens diagnoses", "lens devices" , "lens procedures", "lens udis",
                                               "hip diagnoses", "hip devices","hip procedures",  "hip complications", 
                                               "hip udis", "pacemaker diagnoses", "pacemaker devices", "pacemaker complications",
                                               "pacemaker procedures", "pacemakers udis")
values$summarise_characteristics_cohort_name <- values$summarise_cohort_count_cohort_name 
# edit choices and values of interest
choices <- values
selected <- getSelected(values)

save(data, choices, selected, values, file = file.path(getwd(), "data", "studyData.RData"))

rm(result, values, choices, selected, resultList, data)
