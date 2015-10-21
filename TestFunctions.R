AddNumberGameColumnsToMain <- function(initial_data) {
  initial_data$hasNumber <- grepl("\\d", initial_data$playerName)
  initial_data$totalGames <- initial_data$wins + initial_data$losses

  initial_data
}



#TEST FUNCTION, DOES NOT WORK
GetNumbersFromName <- function(numbered_names) {
  numbered_names$number_1 <- NA
  numbered_names$number_2 <- NA
  numbered_names$number_3 <- NA
  for (i in 1:nrow(numbered_names)) {
    temp <- na.omit(unlist(strsplit(as.character(numbered_names$playerName[[i]]), "[^0-9]+")))
    temp2 <- temp[temp != ""]
    if (length(temp2) >= 1) {
      numbered_names$number_1[[i]] <- temp2[1]
    }
    if (length(temp2) >= 2) {
      numbered_names$number_2[[i]] <- temp2[2]
    }
    if (length(temp2) >= 3) {
      numbered_names$number_3[[i]] <- temp2[3]
    }
  }
  test <- na.omit(unlist(strsplit(as.character(numbered_names$playerName[[14]]), "[^0-9]+")))
  test <- test[test != ""]

  numbered_names
}