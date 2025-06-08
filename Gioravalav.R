library(tidyverse)

data2 <- read.csv("wozdata.csv")
View(data2)

colnames(data2) <- data2[3, ] # maakt de column namen de jaartallen
data2 <- data2[-c(1:5), -c(1, 2, 5:7, 9:11, 13:15, 17:19, 21:23)] #verwijdert onnodige columns en rows
data2 <- na.omit(data2)  # Removes all rows that contain NA values
rownames(data2) <- data2[, 1]  # Set row names using the first column
data2 <- data2[, -1]  # Remove the first column if it's no longer needed




data <- read.csv("inkdata.csv")
View(data)

colnames(data) <- data[5, ] # maakt de column namen de jaartallen
data <- data[-c(1, 2, 3, 4, 5, 6, 11), -c(1, 3, 5, 6, 7, 8, 10, 11, 12, 13, 15, 16, 17, 18, 20, 21, 22, 23, 25, 26, 27, 28)] # cleans up the dataset
rownames(data) <- seq_len(nrow(data)) # unnecesary but makes the row names from 1 to nrow number
colnames(data)[6] <- c("2023") #makes the year 2023 instead of 2023*

rownames(data) <- data[, 1]  # Set row names using the first column
data <- data[,-1]  # Remove the first column if it's no longer needed
data <- apply(data, 2, function(x) gsub(",", ".", x)) # replaces every comma into a decimal


data <- rbind(data, data2) # merges the two datasets
data[] <- lapply(data, function(x) as.numeric(as.character(x))) # makes the characters of all the numbers into numerics


