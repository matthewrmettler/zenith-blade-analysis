source("MakeAPICall.R")
library(httr)
library(jsonlite)

#Load API key
api_key <- readLines(con <- file("key.txt", "r"), warn=FALSE)
close(con)

GetMatchListBySummoner <- function(region="na", summoner.id=0) {
  url <- paste("https://", region, ".api.pvp.net/api/lol/", region, 
               "/v2.2/matchlist/by-summoner/", summoner.id, "?api_key=", api_key, 
               sep="")
  Sys.sleep(0.01)
  req = MakeAPICall(url);
  ## Check status code for errors
  if (!is.null(req)) {
    data <- fromJSON(content(req, "text"))
    
    return(cbind(region, data[[1]]))
  }
  return(list())
}