source("CheckStatus.R")
library(httr)
library(jsonlite)
GetMatchListBySummoner <- function(region, summoner.id) {
  url <- paste("https://", region, ".api.pvp.net/api/lol/", region, 
               "/v2.2/matchlist/by-summoner/", summoner.id, "?api_key=", api_key, 
               sep="")
  req <- GET(url)
  
  ## Check status code for errors
  if (CheckStatus(req)) {
    data <- fromJSON(content(req, "text"))
    
    return(data[[1]])
  }
  return(FALSE)
}