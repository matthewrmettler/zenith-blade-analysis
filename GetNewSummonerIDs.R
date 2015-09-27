source("GetMatchListBySummoner.R")
source("GetSummonerIDsFromMatch.R")
GetNewSummonerIDs <- function(df, count) {
  
  #Get a sample of current IDs
  sampled_ids <- df[sample(nrow(df), count),]
  sample_matches <- c()
  for(id in 1:nrow(sampled_ids)) {
    match_list <- GetMatchListBySummoner(sampled_ids[id,]$region, sampled_ids[id,]$playerOrTeamId)
    sample_matches <- rbind(sample_matches, head(match_list))
  }
  sample_matches <- sample_matches[sample(nrow(sample_matches), count), ]
  sample_new_ids <- c()
  for(id in 1:nrow(sample_matches)) {
    new_ids <- GetSummonerIDsFromMatch(sample_matches[id,]$region, sample_matches[id,]$matchId)
    sample_new_ids <- c(sample_new_ids, new_ids)
  }
  sample_new_ids
}