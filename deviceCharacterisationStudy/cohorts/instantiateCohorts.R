# cohorts ----

if("hip" %in% procedures_to_run){
  logMessage("GETTING HIP COHORTS")
  source(here("hip", "cohorts", "instantiateCohorts.R"))
}
if("lens" %in% procedures_to_run){
  logMessage("GETTING LENS COHORTS")
  source(here("lens", "cohorts", "instantiateCohorts.R"))
}
if("pacemaker" %in% procedures_to_run){
  logMessage("GETTING PACEMAKER COHORTS")
  source(here("pacemaker", "cohorts", "instantiateCohorts.R"))
}
