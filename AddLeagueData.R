
source("GetLeagueBySummoner.R")
AddLeagueData <- function(data, region="na", ids) {
  result <- data
  for(i in ids) {
    result <- rbind(result, GetLeagueBySummoner(region, i))
    Sys.sleep(0.01)
  }
  result <- result[match(unique(result$key),result$key), ]
  result
}