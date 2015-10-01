source("GetNewSummonerIDs.R")
source("AddLeagueData.R")

for (i in 1:10) {
  message(paste("Iteration", i))
  initial_data <- read.csv("data/league_data.csv")
  id <- GetNewSummonerIDs(initial_data, 25)
  data <- AddLeagueData(initial_data, "na", id)
  write.csv(data, "data/league_data.csv", row.names=FALSE)
}