
# diagnoses
list(
  "arrhythmia_codes" = CodelistGenerator::getDescendants(cdm, 44784217)$concept_id,
  "congenital_complete_atrioventricular_block" = CodelistGenerator::getDescendants(cdm, 4069188)$concept_id,
  "acquired_atrioventricular_block" = CodelistGenerator::getDescendants(cdm, c(316135,320744))$concept_id,
  "sinus_node_dysfunction" = CodelistGenerator::getDescendants(cdm, c(317302))$concept_id,
  "long_qt_congenit" = CodelistGenerator::getDescendants(cdm, c(314664,40479232))$concept_id,
  "bradycardia_tachycardia_syndrome" = CodelistGenerator::getDescendants(cdm, c(4254116))$concept_id) |>
    CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "cardiac_construction_disorders_and_arrhythmias"), type = "csv")
list("atrial_septal_defect" = CodelistGenerator::getDescendants(cdm, 653505)$concept_id,
  "ventricular_septal_defect" = CodelistGenerator::getDescendants(cdm, c(434462,653390))$concept_id,
  "atrioventricular_septal_defect" = CodelistGenerator::getDescendants(cdm, c(37164933))$concept_id,
  "tetralogy_of_fallot" = CodelistGenerator::getDescendants(cdm, c(36309515,320835))$concept_id,
  "transposition_of_the_great_arteries" = CodelistGenerator::getDescendants(cdm, c(3656083,3656081))$concept_id,
  "ebstein_anomaly" = CodelistGenerator::getDescendants(cdm, c(4069182))$concept_id) |>
  CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "congenital_heart_diseases"), type = "csv")

list("down_syndrome" = CodelistGenerator::getDescendants(cdm, c(439125,45757375))$concept_id,
     "turner_syndrome" = CodelistGenerator::getDescendants(cdm, c(4307885))$concept_id,
     "noonan_syndrome" = CodelistGenerator::getDescendants(cdm, c(4118400))$concept_id,
     "holt_oram_syndrome" = CodelistGenerator::getDescendants(cdm, c(4078058))$concept_id,
     "williams_syndrome" = CodelistGenerator::getDescendants(cdm, c(4268609))$concept_id) |>
  CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "genetic_and_chromosomal_syndromes"), type = "csv")

list(
  "kearns_sayre_syndrome" = CodelistGenerator::getDescendants(cdm, c(4093427))$concept_id,
  "myotonic_dystrophy" = CodelistGenerator::getDescendants(cdm, c(37161192))$concept_id) |>
  CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "neuromuscular_disorders"), type = "csv")

list(
  "neonatal_lupus" = CodelistGenerator::getDescendants(cdm, c(4316373))$concept_id,
  "cardiomyopathy" = CodelistGenerator::getDescendants(cdm, c(321319))$concept_id,
  "heart_failure" = CodelistGenerator::getDescendants(cdm, c(444101,316139))$concept_id,
  "myocarditis" = CodelistGenerator::getDescendants(cdm, c(314383))$concept_id) |>
  CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "other_comorbidities"), type = "csv")

# procedure codes
pacemaker_implantation_codes <- CodelistGenerator::getDescendants(cdm, c(4051938))$concept_id

# device snomed
pacemaker_codes <- c(45772840, # Implantable cardiac pacemaker
                     45765309, # Intracardiac pacemaker
                     2615795, # Pacemaker, dual chamber, rate-responsive (implantable)
                     45767340, # Dual chamber rate responsive implantable cardiac pacemaker
                     2615796, # Pacemaker, single chamber, rate-responsive (implantable)
                     45767379 # Single chamber rate responsive implantable cardiac pacemaker
)
pacemaker_dual_codes <- c(2615795, 45767340)
pacemaker_single_codes <- c(2615796, 45767379)

# udi
st_jude_dr_assurity_udi_codes <- 05414734509589 |> as.character()
st_jude_sr_assurity_udi_codes <-05414734509572 |> as.character()
st_jude_aveir_udi_codes <- 05415067034472 |> as.character()
biotronik_amvia_sky_udi_codes <- 04035479174026 |> as.character()
medronic_dr_azure_surescan_udi_codes <- 00763000316693 |> as.character()
medronic_sensia_udi_codes <- 00613994177957 |> as.character()
medronic_sr_azure_surescan_udi_codes <- 00763000316716 |> as.character()

# export codelists
list(arrhythmia = arrhythmia_codes,
     pacemaker_implantation = pacemaker_implantation_codes,
     pacemaker = pacemaker_codes,
     pacemaker_dual = pacemaker_dual_codes,
     pacemaker_single = pacemaker_single_codes) |>
  newCodelist() |>
  exportCodelist(here::here("pacemaker", "cohorts","codelists"), type = "csv")

# export udi
readr::write_csv(tibble(udi = st_jude_dr_assurity_udi_codes),
                 here::here("pacemaker", "cohorts","udi", "st_jude_dr_assurity_udi.csv"))
readr::write_csv(tibble(udi = st_jude_sr_assurity_udi_codes),
                 here::here("pacemaker", "cohorts","udi", "st_jude_sr_assurity_udi.csv"))
readr::write_csv(tibble(udi = st_jude_aveir_udi_codes),
                 here::here("pacemaker", "cohorts","udi", "st_jude_aveir_udi.csv"))
readr::write_csv(tibble(udi = biotronik_amvia_sky_udi_codes),
                 here::here("pacemaker", "cohorts","udi", "biotronik_amvia_sky_udi.csv"))
readr::write_csv(tibble(udi = medronic_dr_azure_surescan_udi_codes),
                 here::here("pacemaker", "cohorts","udi", "medronic_dr_azure_surescan_udi.csv"))
readr::write_csv(tibble(udi = medronic_sensia_udi_codes),
                 here::here("pacemaker", "cohorts","udi", "medronic_sensia_udi.csv"))
readr::write_csv(tibble(udi = medronic_sr_azure_surescan_udi_codes),
                 here::here("pacemaker", "cohorts","udi", "medronic_sr_azure_surescan_udi.csv"))



