library(dplyr)
library(omopgenerics)
library(here)
library(CodelistGenerator)
library(readr)
library(visOmopResults)
library(stringr)
library(CohortCharacteristics)
library(tidyr)
library(ggplot2)
library(patchwork)
library(rsvg)
library(DiagrammeRsvg)
library(IncidencePrevalence)
library(flextable)
library(knitr)
library(kableExtra)
library(patchwork)
library(treemapify)
library(CohortSurvival)
source(here("functions.R"))

# settings ----
style <- here("style.yml")
tableType <- "flextable"
plotType  <- "ggplot"
setGlobalPlotOptions(style = style, type = plotType)
setGlobalTableOptions(style = style, type = tableType)
# ----

# Device characterisation ----
devices <- read_csv(here("Results", "devices.csv")) |>
  mutate("cdm_name" = gsub("_OMOP", "", cdm_name))
data <- importSummarisedResult(path = here("Results", "results_GOSH_OMOP_devices.csv")) |>
  mutate("cdm_name" = gsub("_OMOP", "", cdm_name))

working_data <- data |>
  filterSettings(result_type == "summarise_table") |>
  omopgenerics::tidy() |>
  left_join(devices |>
              select(!"device_name") |>
              mutate(device_concept_id = as.character(device_concept_id)),
            by = join_by(cdm_name, device_concept_id,
                         device_concept_id_name, unique_device_id))

working_data |>
  filter(is_medical_device == "yes") |>
  filter_out(device_concept_id == "0" & is.na(gudid_brand_name)) |>
  filter(str_detect(cdm_name, "CPRD GOLD|Aurum", negate = TRUE)) |>
  group_by(cdm_name, medical_speciality) |>
  summarise(total_count = sum(count, na.rm = TRUE), .groups = "drop") |>
  ggplot(aes(area = total_count, fill = medical_speciality, label = medical_speciality)) +
  geom_treemap() +
  geom_treemap_text(
    colour = "white",
    place = "centre",
    grow = TRUE,
    reflow = TRUE
  ) +
  labs(title = "Counts by Medical Specialty") +
  theme(legend.position = "bottom",
        legend.title = element_blank()) +
  facet_wrap(vars(cdm_name))

working_data |>
  filter(is_medical_device == "yes") |>
  filter_out(device_concept_id == "0" & is.na(gudid_brand_name)) |>
  filter(str_detect(cdm_name, "CPRD GOLD|Aurum", negate = TRUE)) |>
  group_by(cdm_name, device_class) |>
  summarise(total_count = sum(count, na.rm = TRUE), .groups = "drop") |>
  ggplot(aes(area = total_count, fill = device_class, label = device_class)) +
  geom_treemap() +
  geom_treemap_text(
    colour = "white",
    place = "centre",
    grow = TRUE,
    reflow = TRUE
  ) +
  labs(title = "Counts by Device Class") +
  theme(legend.position = "bottom",
        legend.title = element_blank()) +
  facet_wrap(vars(cdm_name))
# ----



# Pacemakers -----
res <- importSummarisedResult(path = here("Results/results_GOSH_OMOP_2026_11_26.csv"))

# Cohort count
x <- getGroup(c("pacemaker devices", "pacemaker procedures"))
res |>
  filterSettings(result_type == "summarise_cohort_count") |>
  filterGroup(cohort_name  %in% !!x) |>
  tableCohortCount(header = c("cdm_name", "variable_name"))

# Cohort characteristics
res |>
  filterSettings(result_type == "summarise_characteristics") |>
  filterGroup(cohort_name %in% !!getGroup(c("pacemaker devices"))) |>
  filter(!variable_name %in% c("Cohort end date", "Prior observation", "Future observation",
                              "Days in cohort"),
         !variable_level %in% c("Pacemaker removal", "Pacemaker repair",
                                "Pacemaker replacement", "Pacemaker relocation")) |>
  tableCharacteristics()

# Cohort characteristics procedures
res |>
  filterSettings(result_type == "summarise_characteristics") |>
  filterGroup(grepl("pacemaker", cohort_name)) |>
  filterGroup(grepl("implantation", cohort_name)) |>
  filter(variable_name %in% c("Devices", "Devices (sensitivity)")) |>
  tableCharacteristics()

# Cohort survival
res |>
  filterSettings(grepl("survival", result_type)) |>
  plotSurvival(facet = "target_cohort",
               colour = "outcome",
               timeScale = "years")

