
# diagnoses
list(
  "acquired_atrioventricular_block" = CodelistGenerator::getDescendants(cdm, c(316135,320744))$concept_id,
  "atrioventricular_block" = CodelistGenerator::getDescendants(cdm, c(313780,314379,316135,318448,320425,320744))$concept_id,
  "sinus_node_dysfunction" = CodelistGenerator::getDescendants(cdm, c(4119603,4261842))$concept_id,
  "long_qt" = CodelistGenerator::getDescendants(cdm, c(37163279,37163281,37163282, 37163284, 37163286, 37163287,
                                                       37163297,37163299,37163323))$concept_id,
  "bradycardia_tachycardia_syndrome" = CodelistGenerator::getDescendants(cdm, c(4254116))$concept_id,
  "bradycardia" = CodelistGenerator::getDescendants(cdm, c(4171683, 4142566,4169095))$concept_id,
  "bundle_branch_block" = CodelistGenerator::getDescendants(cdm, c(313209,313791,316998, 4138973,314059))$concept_id,
  "arrhythmia_codes" = CodelistGenerator::getDescendants(cdm, 44784217)$concept_id) |>
  CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "cardiac_construction_disorders_and_arrhythmias"), type = "csv")

list("down_syndrome" = CodelistGenerator::getDescendants(cdm, c(439125,45757375))$concept_id,
     "turner_syndrome" = CodelistGenerator::getDescendants(cdm, c(4307885))$concept_id,
     "noonan_syndrome" = CodelistGenerator::getDescendants(cdm, c(4118400))$concept_id,
     "myotonic_dystrophy" = CodelistGenerator::getDescendants(cdm, c(37161192))$concept_id,
     "emery_dreifuss_muscular_dystrophy" = CodelistGenerator::getDescendants(cdm, c(4009185))$concept_id,
     "holt_oram_syndrome" = CodelistGenerator::getDescendants(cdm, c(4078058))$concept_id,
     "atrial_septal_defect" = CodelistGenerator::getDescendants(cdm, 653505)$concept_id,
     "ventricular_septal_defect" = CodelistGenerator::getDescendants(cdm, c(434462,653390))$concept_id,
     "atrioventricular_septal_defect" = CodelistGenerator::getDescendants(cdm, c(37164933))$concept_id,
     "tetralogy_of_fallot" = CodelistGenerator::getDescendants(cdm, c(36309515,320835))$concept_id,
     "transposition_of_the_great_arteries" = CodelistGenerator::getDescendants(cdm, c(3656083,3656081))$concept_id,
     "ebstein_anomaly" = CodelistGenerator::getDescendants(cdm, c(4069182))$concept_id,
     "williams_syndrome" = CodelistGenerator::getDescendants(cdm, c(4268609))$concept_id,
     "congenital_complete_atrioventricular_block" = CodelistGenerator::getDescendants(cdm, c(4069188))$concept_id,
     "long_qt_congenital" = CodelistGenerator::getDescendants(cdm, c(40479232,314664))$concept_id,
     "sinus_node_dysfunction_child" = CodelistGenerator::getDescendants(cdm, c(317302))$concept_id) |>
  CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "congenital_heart_diseases"), type = "csv")


list("cardiomyopathy" = CodelistGenerator::getDescendants(cdm, c(321319, 4190773, 4261970, 4163710, 42573220))$concept_id) |>
  CodelistGenerator::exportCodelist(path = here::here("cohorts", "pacemaker", "cohorts", "codelists", "cardiovascular_risk_diseases"), type = "csv")

list(
  "valvular_heart_disease" = CodelistGenerator::getDescendants(cdm, c(4281749, 4195003, 4182110))$concept_id,
  "hypertensive_heart_disease" = CodelistGenerator::getDescendants(cdm, c(442604))$concept_id) |>
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



