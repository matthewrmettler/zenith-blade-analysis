# Returns a data frame containing the contents of the 'get league by summoner'
# API call. Data frame also includes the tier and region of that call.
source("MakeAPICall.R")
library(jsonlite)

#Load API key
api_key <- suppressWarnings(readLines(con <- file("key.txt", "r")))
close(con)

GetLeagueBySummoner <- function(region="na", summoner.id=0) {
  url <- paste("https://", region, ".api.pvp.net/api/lol/", region, 
               "/v2.5/league/by-summoner/", summoner.id, "?api_key=", api_key, 
               sep="")
  req = MakeAPICall(url);
  ## Check status code for errors
  if (!is.null(req)) {
    raw_data <- fromJSON(content(req, "text"))
    
    temp <- raw_data[[1]]
    for (q in 1:nrow(temp)) {
      if (as.character(temp[q,]$queue) == "RANKED_SOLO_5x5") {
        #print(q)
        solo_q <- temp[q, ]
      }
    }
    if (!exists("solo_q")) {
      return(c())
    }
    tier <- solo_q$tier
    entries <- solo_q$entries[[1]]
    key <- paste(region, entries[ , 1])
    data <- cbind(key, region, entries[ , 1:2], tier, entries[ , 3:10])
    
    ## Format columns and names
    names(data)[1] <- "key"
    names(data)[2] <- "region"
    names(data)[3] <- "playerId"
    names(data)[4] <- "playerName"
    names(data)[5] <- "tier"
    
    data[ , 2] <- as.factor(data[ , 2])
    
    data[ , 7] <- as.numeric(as.character(data[ , 7]))
    data[ , 8] <- as.numeric(as.character(data[ , 8]))
    data[ , 9] <- as.numeric(as.character(data[ , 9]))
    
    data[ , 10] <- as.logical(data[ , 10])
    data[ , 11] <- as.logical(data[ , 11])
    data[ , 12] <- as.logical(data[ , 12])
    data[ , 13] <- as.logical(data[ , 13])
    rownames(data) <- NULL
    
    return(data)
  }
  return(c())
}