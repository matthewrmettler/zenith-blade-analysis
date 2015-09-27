initial_data <- read.csv("data/league_data.csv")

source("GetNewSummonerIDs.R")
test <- GetNewSummonerIDs(initial_data, 10)

source("GetSummonerIDsFromMatch.R")
test2 <- GetSummonerIDsFromMatch("na", test[1,]$matchId)