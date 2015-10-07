## Thide code is meant to test how fast my code is, in order to attempt to optimize it

source("GetLeagueBySummoner.R")
Rprof("league2.out")
test2 <- GetLeagueBySummoner("na", 51000358)
Rprof(NULL)
summaryRprof("league2.out")

