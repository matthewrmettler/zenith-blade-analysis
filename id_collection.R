library(httr)
library(jsonlite)

#Seed IDs
bronze_seed_id = 21938826
silver_seed_id = 46590181
gold_seed_id = 22497997
platinum_seed_id = 23316933
diamond_seed_id = 19859333
seed_ids = c(bronze_seed_id, silver_seed_id, gold_seed_id, platinum_seed_id, diamond_seed_id)

#Load API key
api_key <- readLines(con <- file("key.txt", "r"))
close(con)

CheckStatus <- function(api_call, url) {
  if (status_code(api_call) == 200) {
    return(TRUE)
  } else {
    if (status_code(req) == 400) {
      # Bad syntax, the url is wrong
      print("Response code 400, fix the url!")
      return(FALSE)
      
    } else if (status_code(req) == 401) {
      # No authorization, bad api key
      print("Response code 401, bad API key / no key provided!")
      return(FALSE)
      
    } else if (status_code(req) == 404) {
      # Summoner not found!
      print("Response code 404, summoner not found!")
      return(FALSE)
      
    } else if (status_code(req) == 429) {
      print("Response code 429, rate limit exceeded! 
            Trying again in 1.0 seconds...")
      Sys.sleep(1.0)
      return(CheckStatus(GET(url), url))
      
    } else if (status_code(req) == 500) {
      print("Response code 500, internal server error! 
            Try again later?")
      return(FALSE)
      
    } else if (status_code(req) == 503) {
      print("Response code 503, service unavailable!
            Try again later?")
      return(FALSE)
    } 
  }
}

# Returns a data frame containing the contents of the 'get league by summoner'
# API call. Data frame also includes the tier and region of that call.
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

league.table <- list()
for(id in seed_ids) {
  temprow <- GetLeagueBySummoner("na", id)
  rownames(league.table) <- rownames(temprow) <- NULL
  league.table <- rbind(league.table, GetLeagueBySummoner("na", id))
}

test <- league.table[sample(nrow(league.table), 20), ]