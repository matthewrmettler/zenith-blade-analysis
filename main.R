source("GetNewSummonerIDs.R")
source("AddLeagueData.R")
source("TestFunctions.R")

collect_data <- function(size) {
  initial_data <- read.csv("data/league_data.csv")
  id <- GetNewSummonerIDs(initial_data, size)
  data <- AddLeagueData(initial_data, "na", id, size*5)
  write.csv(data, "data/league_data.csv", row.names=FALSE)
}

collect_data(350)