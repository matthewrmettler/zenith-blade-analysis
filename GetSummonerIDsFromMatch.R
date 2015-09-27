
source("CheckStatus.R")
#Load API key
api_key <- readLines(con <- file("key.txt", "r"), warn=FALSE)
close(con)

GetSummonerIDsFromMatch <- function(region, match.id) {
  url <- paste("https://", region, ".api.pvp.net/api/lol/", region, 
               "/v2.2/match/", match.id, "?api_key=", api_key, 
               sep="")
  Sys.sleep(0.25)
  req <- GET(url)
  
  ## Check status code for errors
  if (CheckStatus(req)) {
    data <- fromJSON(content(req, "text"))
    result <- data$participantIdentities$player$summonerId
    return(result)
  }
  return(FALSE)
}