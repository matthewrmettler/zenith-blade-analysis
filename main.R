source("GetNewSummonerIDs.R")
source("AddLeagueData.R")

collect_data <- function(size) {
  initial_data <- read.csv("data/league_data.csv")
  id <- GetNewSummonerIDs(initial_data, size)
  data <- AddLeagueData(initial_data, "na", id, size*5)
  write.csv(data, "data/league_data.csv", row.names=FALSE)
}

#collect_data(250)

plot_testing <- function(initial_data) {
  levels(initial_data$tier) <- c("BRONZE", "SILVER", "GOLD", "PLATINUM", "DIAMOND", "MASTER", "CHALLENGER")
  
  par(mfrow = c(1,2))
  boxplot(totalGames ~ tier, initial_data, xLab = "Tier", ylab = "Total games played", outline=FALSE)
  boxplot(totalGames ~ tier, subset(initial_data, hasNumber==TRUE), xLab = "Tier", ylab = "Numbered name games played", outline=FALSE)
}

#plot_testing(read.csv("data/league_data.csv"))