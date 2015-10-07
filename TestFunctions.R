AddNumberGameColumnsToMain <- function(initial_data) {
  initial_data$hasNumber <- grepl("\\d", initial_data$playerName)
  initial_data$totalGames <- initial_data$wins + initial_data$losses
  
  write.csv(initial_data, "data/league_data.csv", row.names=FALSE)
}

#TEST FUNCTION, DOES NOT WORK
GetNumbersFromName <- function(data) {
  #for (i in 1:nrow(numbered_names)) {
  numbered_names$numbers <- NA
  for (i in 1:nrow(numbered_names)) {
    temp <- na.omit(unlist(strsplit(as.character(numbered_names$playerName[[i]]), "[^0-9]+")))
    temp2 <- temp[temp != ""]
    numbered_names$number[[i]] <- list(temp2)
  }
  test <- na.omit(unlist(strsplit(as.character(numbered_names$playerName[[14]]), "[^0-9]+")))
  test <- test[test != ""]
  
  numbered_names$number[[14]]
}