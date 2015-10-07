
source("GetLeagueBySummoner.R")
AddLeagueData <- function(data, region="na", ids, size) {
  ids <- sample(ids, size=size)
  result <- c()
  for(i in ids) {
    result <- rbind(result, GetLeagueBySummoner(region, i))
  }
  result <- rbind(data, result)
  result <- result[match(unique(result$key),result$key), ]
  result
}