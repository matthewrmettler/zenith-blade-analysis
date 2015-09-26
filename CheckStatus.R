library(httr)
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