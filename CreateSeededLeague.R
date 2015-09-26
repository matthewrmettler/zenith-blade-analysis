#Load needed functions
source("GetLeagueBySummoner.R")

#Load API key
api_key <- readLines(con <- file("key.txt", "r"))
close(con)

CreateSeededLeague <- function() {
  #Seed IDs
  bronze_seed_id = 21938826
  silver_seed_id = 46590181
  gold_seed_id = 22497997
  platinum_seed_id = 23316933
  diamond_seed_id = 19859333
  seed_ids = c(bronze_seed_id, silver_seed_id, gold_seed_id, platinum_seed_id, diamond_seed_id)
  
  league.table <- list()
  for(id in seed_ids) {
    temprow <- GetLeagueBySummoner("na", id)
    rownames(league.table) <- rownames(temprow) <- NULL
    league.table <- rbind(league.table, GetLeagueBySummoner("na", id))
  }
  write.csv(league.table, "data/league_data.csv", row.names=FALSE)
}
