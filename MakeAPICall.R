
library(httr)
MakeAPICall <- function(url) {
  if (is.null(url)) {
    return(NULL)
  }
  result <- tryCatch(
    {
      GET(url)
    },
    error=function(cond) {
      message(paste("Error with URL:", url))
      message("Original error message:")
      message(cond)
      return(NULL)
    },
    warning=function(cond) {
      message(paste("Warning with URL:", url))
      message("Original error message:")
      message(cond)
    },
    finally={
      message(paste("Processed url:", url))
    }
  )
  if (!is.null(result)) {
    if (status_code(result) == 200) {
      return(result)
    }
  }
  return(NULL)
}