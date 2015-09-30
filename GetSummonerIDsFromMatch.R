
source("MakeAPICall.R")
#Load API key
api_key <- readLines(con <- file("key.txt", "r"), warn=FALSE)
close(con)

GetSummonerIDsFromMatch <- function(region="na", match.id="-1") {
  url <- paste("https://", region, ".api.pvp.net/api/lol/", region, 
               "/v2.2/match/", match.id, "?api_key=", api_key, 
               sep="")
  Sys.sleep(0.01)
  req = MakeAPICall(url);
  ## Check status code for errors
  if (!is.null(req)) {
    data <- fromJSON(content(req, "text"))
    result <- data$participantIdentities$player$summonerId
    return(result)
  }
  return(FALSE)
}