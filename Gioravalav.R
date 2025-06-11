library(ggplot2)
library(tidyverse)

data2 <- read.csv("wozdata.csv")
View(data2)

colnames(data2) <- data2[3, ] # turns the column names in the years
data2 <- data2[-c(1:5, 19:379), -c(1, 2, 5:7, 9:11, 13:15, 17:19, 21:23)] #verwijdert onnodige columns en rows
data2 <- na.omit(data2)  # Removes all rows that contain NA values
rownames(data2) <- data2[, 1]  # Set row names using the first column
data2 <- data2[, -1]  # Remove the first column if it's no longer needed




data <- read.csv("inkdata.csv")
View(data)

colnames(data) <- data[5, ] # turns the column names in a year
data <- data[-c(1, 2, 3, 4, 5, 6, 11), -c(1, 3, 5, 6, 7, 8, 10, 11, 12, 13, 15, 16, 17, 18, 20, 21, 22, 23, 25, 26, 27, 28)] # cleans up the data set
rownames(data) <- seq_len(nrow(data)) # unnecessary but makes numbers the rows correctly
colnames(data)[6] <- c("2023") #makes the year 2023 instead of 2023*

rownames(data) <- data[, 1]  # Set row names using the first column
data <- data[,-1]  # Remove the first column if it's no longer needed
data <- apply(data, 2, function(x) gsub(",", ".", x)) # replaces every comma into a decimal


data <- rbind(data, data2) # merges the two data sets
data[] <- lapply(data, function(x) as.numeric(as.character(x))) # makes the characters of all the numbers into numeric

new_row <- data[5, ] / data[3,]  # Element-wise division

rownames(new_row) <- "Houseprices in Netherland relative to Avg personal income"

data <- rbind(data[1:4, ], new_row, data[5:nrow(data), ])

# under here is the code to plot the new row 

graph_data <- data.frame(
  Year = colnames(data)[1:5],  # Extract year labels
  Value = as.numeric(data[5, 1:5])  # Convert row values to numeric
)

ggplot(graph_data, aes(x = Year, y = Value, group = 1)) +  # Explicitly set `group = 1`
  geom_line(color = "blue", linewidth = 1) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Houseprices in Netherlands Relative to Personal Income",
    x = "Year",
    y = "Relative Value"
  ) +
  theme_bw()



data2[] <- lapply(data2, function(x) as.numeric(as.character(x))) # makes the characters of all the numbers into numeric in the old data2
dif <- c() # give variable dif the value of a vector

for(i in 1:nrow(data2))
{
  dif[i] = data2$"2023"[i] / data2$"2019"[i] # Element division  
}

data2 <- cbind(data2, dif) # add the dif variable to the data2 dataset

voltijd <- read.csv("inkdata.csv")
View(voltijd)

colnames(voltijd) <- voltijd[5, ] # turns the column names in a year
voltijd <- voltijd[-c(1, 2, 3, 4, 5, 6, 11), -c(1, 3, 4, 5, 6, 7, 9, 10, 11, 12, 14, 15, 16, 17, 19, 20, 21, 22, 24, 25, 26, 27)] # cleans up the data set
colnames(voltijd)[6] <- c("2023") #makes the year 2023 instead of 2023*

rownames(voltijd) <- voltijd[, 1]  # Set row names using the first column
voltijd <- voltijd[,-1]  # Remove the first column if it's no longer needed
voltijd <- voltijd[-c(1, 2, 4), ] # cleans up the data set

rownames(voltijd)[1] <- "Werkzame beroepsbevolking met full time jobs|Gemiddeld persoonlijk inkomen"
voltijd[] <- lapply(voltijd, function(x) as.numeric(gsub(",", ".", x)))

data <- data[-c(1, 2, 4), ] # cleans up the data set

data <- rbind(data[1, ], voltijd, data[2:nrow(data), ])

new_row_vol <- data[4, ] / data[2,]  # Element-wise division
rownames(new_row_vol) <- "Houseprices in Netherlands relative to Avg personal full time income"
data <- rbind(data[1:2, ], new_row_vol, data[3:nrow(data), ])

graph_data <- data.frame(
  Year = colnames(data)[1:5],  # Extract year labels
  Value = as.numeric(data[3, 1:5])  # Convert row values to numeric
)

ggplot(graph_data, aes(x = Year, y = Value, group = 1)) +  # Explicitly set `group = 1`
  geom_line(color = "blue", linewidth = 1) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Houseprices in Netherlands Relative to Personal full time Income",
    x = "Year",
    y = "Relative Value"
  ) +
  theme_bw()