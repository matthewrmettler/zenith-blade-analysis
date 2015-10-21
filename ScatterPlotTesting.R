source("TestFunctions.R")

data <- read.csv("data/league_data.csv")
levels(data$tier) <- c("BRONZE", "SILVER", "GOLD", "PLATINUM", "DIAMOND", "MASTER", "CHALLENGER")
levels(data$division) <- c("V", "IV", "III", "II", "I")
data <- AddNumberGameColumnsToMain(data)
sample_data <- data[sample(nrow(data), 1000), ]



base_plot_testing <- function(data) {
  par(mfrow = c(1,2))
  boxplot(log(totalGames) ~ tier, data, xLab = "Tier", ylab = "Total games played", outline=FALSE)
  boxplot(log(totalGames) ~ tier, subset(data, hasNumber==TRUE), xLab = "Tier", ylab = "Numbered name games played", outline=FALSE)
}



ggplot2_plot_testing <- function(data) {
  library(ggplot2)
  plot <- qplot(leaguePoints, totalGames, data=data, facet = tier ~ .)
}




smooth_scatter_testing <- function(data){
  x <- data$division
  y <- data$totalGames
  smoothScatter(x,y)
}



base_plot_testing(data)

res <- ggplot2_plot_testing(sample_data)
print(res)

smooth_scatter_testing(sample_data)

sample_num_data <- GetNumbersFromName(sample_data)
sample_num_data$number_1 <- as.numeric(sample_num_data$number_1)
sample_num_data$number_2 <- as.numeric(sample_num_data$number_2)
sample_num_data$number_3 <- as.numeric(sample_num_data$number_3)
number_list <- with(sample_num_data, c(number_1[!is.na(number_1)], number_2[!is.na(number_2)], number_3[!is.na(number_3)]))
table(number_list)
hist(number_list)