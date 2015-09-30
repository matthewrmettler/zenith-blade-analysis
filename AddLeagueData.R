
source("GetLeagueBySummoner.R")
AddLeagueData <- function(data, region="na", ids) {
  result <- data
  for(i in ids) {
    new_df <- rbind(result, GetLeagueBySummoner(region, i))
    result <- new_df[match(unique(new_df$key),new_df$key), ]
    Sys.sleep(0.01)
  }
  result
}