library(httr)
library(jsonlite)

#Bronze: 21938826
#Silver: 46590181
#Gold: 22497997
#Platinum: 23316933
#Diamond: 19859333
seed_ids = c(21938826, 46590181, 22497997, 23316933, 19859333)
api_key <- readLines(con <- file("key.txt", "r"))

GetLeagueBySummoner <- function(region, summoner.id) {
  url <- paste("https://", region, ".api.pvp.net/api/lol/", region, 
               "/v2.5/league/by-summoner/", summoner.id, "?api_key=", api_key, 
               sep="")
  req <- GET(url)
  
  ## Check status code for errors
  if (status_code(req) == 200) {
    return(fromJSON(content(req, "text")))
    
  } else {
    if (status_code(req) == 400) {
      # Bad syntax, the url is wrong
      print("Response code 400, fix the url!")
      return(-1)
      
    } else if (status_code(req) == 401) {
      # No authorization, bad api key
      print("Response code 401, bad API key / no key provided!")
      return(-1)
      
    } else if (status_code(req) == 404) {
      # Summoner not found!
      print("Response code 404, summoner not found!")
      return(0)
      
    } else if (status_code(req) == 429) {
      print("Response code 429, rate limit exceeded! 
            Trying again in 1.0 seconds...")
      Sys.sleep(1.0)
      return(GetLeague(region, summoner.id))
      
    } else if (status_code(req) == 500) {
      print("Response code 500, internal server error! 
            Try again later?")
      return(-1)
      
    } else if (status_code(req) == 503) {
      print("Response code 503, service unavailable!
            Try again later?")
      return(-1)
    } 
  }
}

raw_data <- GetLeagueBySummoner("na", seed_ids[1])
data = raw_data[[1]]
entries = data[[4]][[1]]