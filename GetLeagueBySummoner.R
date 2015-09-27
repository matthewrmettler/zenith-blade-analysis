# Returns a data frame containing the contents of the 'get league by summoner'
# API call. Data frame also includes the tier and region of that call.
source("CheckStatus.R")
library(httr)
library(jsonlite)

#Load API key
api_key <- readLines(con <- file("key.txt", "r"))
close(con)

GetLeagueBySummoner <- function(region, summoner.id) {
  url <- paste("https://", region, ".api.pvp.net/api/lol/", region, 
               "/v2.5/league/by-summoner/", summoner.id, "?api_key=", api_key, 
               sep="")
  req <- GET(url)
  
  ## Check status code for errors
  if (CheckStatus(req)) {
    raw_data <- fromJSON(content(req, "text"))
    named_data <- raw_data[[1]]
    solo_q <- named_data[1,]
    tier <- solo_q$tier
    entries <- solo_q$entries[[1]]
    data <- cbind(entries, tier)
    shuffled_data <- cbind(region, data[,1:2], data[,12], data[,3:10])
    names(shuffled_data)[4] <- "tier"
    rownames(shuffled_data) <- NULL
    return(shuffled_data)
  }
  return(list())
}