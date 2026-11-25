# cohorts ----

if("hip" %in% procedures_to_run){
  logMessage("GETTING HIP COHORTS")
  source(here("cohorts", "hip", "cohorts", "instantiateCohorts.R"))
}
if("lens" %in% procedures_to_run){
  logMessage("GETTING LENS COHORTS")
  source(here("cohorts", "lens", "cohorts", "instantiateCohorts.R"))
}
if("pacemaker" %in% procedures_to_run){
  logMessage("GETTING PACEMAKER COHORTS")
  source(here("cohorts", "pacemaker", "cohorts", "instantiateCohorts.R"))
}
