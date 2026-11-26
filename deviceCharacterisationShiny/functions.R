
getGroup <- function(input)  {
  group <- c()
  group <- if ("lens diagnoses" %in% input) {append(group, c("cataract"))} else {group}
  group <- if ("lens devices" %in% input) {append(group, c("lens_anterior", "lens_posterior", "lens"))} else {group}
  group <- if ("lens procedures" %in% input) {append(group, c("lens_implantation"))} else {group}
  group <- if ("lens udis" %in% input) {append(group, c("alcon_acrsysof_udi", "bl_akreos_micro_udi",
                                                        "bl_sofport_iol_udi_codes", "jnj_tecnis_iol_udi"))} else {group}

  group <- if ("hip diagnoses" %in% input) {append(group, c("hip_fx", "hip_oa"))} else {group}
  group <- if ("hip devices" %in% input) {append(group, c("femoral_head_bipolar", "femoral_head_ceramic", "femoral_head_metallic",
                                                          "femoral_head_unspecified"))} else {group}
  group <- if ("hip procedures" %in% input) {append(group, c("hemi_cemented_revision", "hemi_cemented", "hemi_revision",
                                                             "hemi_uncemented_revision", "hemi_uncemented", "hemi_uncemented",
                                                             "hemi_unspecified"))} else {group}
  group <- if ("hip complications" %in% input) {append(group, c("vte"))} else {group}
  group <- if ("hip udis" %in% input) {append(group, c("depuy_articul_eze_udi", "depuy_c_stem_udi",
                                                       "depuy_corail_udi", "depuy_self_centering_udi",
                                                       "adler_metallic_ceramic_udi", "biomet_biolox_ceramic_udi",
                                                       "biomet_hip_system_metallic_udi", "corin_metallic_udi"))} else {group}

  group <- if ("pacemaker diagnoses" %in% input) {append(group, c("acquired_atrioventricular_block", "arrhythmia", "bradycardia_tachycardia_syndrome", "congenital_complete_atrioventricular_block",
                                                                  "long_qt_congenit", "sinus_node_dysfunction", "atrial_septal_defect", "atrioventricular_septal_defect",
                                                                  "ebstein_anomaly", "tetralogy_of_fallot", "transposition_of_the_great_arteries", "ventricular_septal_defect",
                                                                  "down_syndrome", "holt_oram_syndrome", "noonan_syndrome", "turner_syndrome", "williams_syndrome", "kearns_sayre_syndrome",
                                                                  "myotonic_dystrophy", "cardiomyopathy", "heart_failure", "myocarditis", "neonatal_lupus"))} else {group}
  group <- if ("pacemaker devices" %in% input) {append(group, c("pacemaker_dual", "pacemaker_single", "pacemaker_unspecified"))} else {group}
  group <- if ("pacemaker complications" %in% input) {append(group, c("endocarditis"))} else {group}
  group <- if ("pacemaker procedures" %in% input) {append(group, c("pacemaker_implantation_dual", "pacemaker_implantation_single", "pacemaker_implantation_unspecified",
                                                                   "pacemaker_relocation", "pacemaker_removal", "pacemaker_repair", "pacemaker_replacement"))} else {group}
  group <- if ("pacemakers udis" %in% input) {append(group, c("biotronik_amvia_sky_udi", "medtronic_dr_azure_surescan_udi",
                                                              "medtronic_dr_sensia_udi", "medtronic_ic_micra","medtronic_sr_azure_surescan_udi",
                                                              "medtronic_sr_sensia_udi", "st_jude_aveir_udi", "st_jude_dr_assurity_udi",
                                                              "st_jude_sr_assurity_udi", "st_jude_sr_microny_udi"))} else {group}

  return(group)
}

