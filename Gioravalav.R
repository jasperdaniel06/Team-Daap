data2 <- read.csv("wozdata.csv")

colnames(data2) <- data2[3, ] # turns the column names in the years
data2 <- data2[-c(1:5, 19:379), -c(1, 2, 5:7, 9:11, 13:15, 17:19, 21:23)] #verwijdert onnodige columns en rows
data2 <- na.omit(data2)  # Removes all rows that contain NA values
rownames(data2) <- data2[, 1]  # Set row names using the first column
data2 <- data2[, -1]  # Remove the first column if it's no longer needed




data <- read.csv("inkdata.csv")

colnames(data) <- data[5, ] # turns the column names in a year
data <- data[-c(1, 2, 3, 4, 5, 6, 11), -c(1, 3, 5, 6, 7, 8, 10, 11, 12, 13, 15, 16, 17, 18, 20, 21, 22, 23, 25, 26, 27, 28)] # cleans up the data set by deleting certain columns and rows that are not needed
rownames(data) <- seq_len(nrow(data)) # unnecessary but makes numbers in the rows correctly into the number of each row
colnames(data)[6] <- c("2023") #makes the year 2023 instead of 2023*

rownames(data) <- data[, 1]  # Set row names using the first column
data <- data[,-1]  # Remove the first column if it's no longer needed
data <- apply(data, 2, function(x) gsub(",", ".", x)) # replaces every comma into a decimal


data <- rbind(data, data2) # merges the two data sets
data[] <- lapply(data, function(x) as.numeric(as.character(x))) # makes the characters of all the numbers into numeric

new_row <- data[5, ] / data[3,]  # Element-wise division of average Netherlands house prices divided by average personal income

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
    title = "Houseprices Relative to Avg Personal Income in The Netherlands",
    x = "Year",
    y = "Relative Value"
  ) +
  theme_bw()



data2[] <- lapply(data2, function(x) as.numeric(as.character(x))) # makes the characters of all the numbers into numeric in the old data2
dif <- c() # give variable dif the value of a vector

for(i in 1:nrow(data2))
{
  dif[i] = data2$"2023"[i] / data2$"2019"[i] # divides the house prices in 2023 by the houseprices in 2019 
}

data2 <- cbind(data2, dif) # add the dif variable to the data2 dataset

slice_max(data2, dif) # finds max relative difference
slice_min(data2, dif) # finds min relative difference

# code to find houseprices relative to income in these places

zeefle <- read.csv2("zeefle.csv")
rownames(zeefle)[1] <- "Gemiddeld persoonlijk inkomen in Flevoland"
rownames(zeefle)[2] <- "Gemiddeld persoonlijk inkomen in Zeeland"
zeefle <- zeefle[, -c(1:4, 6:9, 11:14, 16:19, 21:24)] # only keeps the average income of Flevoland and Zeeland
colnames(zeefle) <- c("2019", "2020", "2021", "2022", "2023")

zeefle[] <- lapply(zeefle, function(x) as.numeric(as.character(x))) # makes the characters of all the numbers into numeric

data <- rbind(data, zeefle)

rownumber_fle <- which(rownames(data) == "Flevoland (PV)")
rownumber_zee <- which(rownames(data) == "Zeeland (PV)")
rownumber_fle
rownumber_zee

new_row_fle <- data[11, ] / data[19,]  # Element-wise division of Flevoland's houseprices divided by the average income in Flevoland
new_row_zee <- data[16, ] / data[20,]  # Element-wise division of Zeeland's houseprices divided by the average income in Zeeland

rownames(new_row_fle) <- "Houseprices in Flevoland relative to Avg personal income"
rownames(new_row_zee) <- "Houseprices in Zeeland relative to Avg personal income"

data <- rbind(data[1:5, ], new_row_fle, data[6:nrow(data), ])
data <- rbind(data[1:6, ], new_row_zee, data[7:nrow(data), ])

# under here is the code to plot the new of Flevoland
graph_data <- data.frame(
  Year = colnames(data)[1:5],  # Extract year labels
  Value = as.numeric(data[6, 1:5])  # Convert row values to numeric
)

ggplot(graph_data, aes(x = Year, y = Value, group = 1)) +  # Explicitly set `group = 1`
  geom_line(color = "blue", linewidth = 1) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Houseprices Relative to Avg Personal Income in Flevoland",
    x = "Year",
    y = "Relative Value"
  ) +
  theme_bw()

# under here is the code to plot the new row of Zeeland

graph_data <- data.frame(
  Year = colnames(data)[1:5],  # Extract year labels
  Value = as.numeric(data[7, 1:5])  # Convert row values to numeric
)

ggplot(graph_data, aes(x = Year, y = Value, group = 1)) +  # Explicitly set `group = 1`
  geom_line(color = "blue", linewidth = 1) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Houseprices Relative to Avg Personal Income in Zeeland",
    x = "Year",
    y = "Relative Value"
  ) +
  theme_bw()

# under here is the code to plot all the line graphs before this in one graph
graph_data <- data.frame(
  Year = colnames(data)[1:5],  # Extract years
  Netherlands = as.numeric(data[5, 1:5]),  # Row 5: Netherlands
  Flevoland = as.numeric(data[6, 1:5]),  # Row 6: Flevoland
  Zeeland = as.numeric(data[7, 1:5])   # Row 7: Zeeland
)

# Convert data to long format
graph_data_long <- pivot_longer(graph_data, cols = -Year, names_to = "Region", values_to = "Value")

# Create the multi-line plot
ggplot(graph_data_long, aes(x = Year, y = Value, color = Region, group = Region)) + 
  geom_line(linewidth = 1) + 
  geom_point(size = 2) + 
  labs(
    title = "House Prices Relative to Average Personal Income (2019-2023)",
    x = "Year",
    y = "Relative Value"
  ) +
  theme_bw()

graph_data <- data.frame(
  Year = colnames(data)[1:5],  # Extract year labels
  Value = as.numeric(data[8, 1:5])  # Convert row values to numeric
)

ggplot(graph_data, aes(x = Year, y = Value, group = 1)) +  # Explicitly set `group = 1`
  geom_line(color = "blue", linewidth = 1) +
  geom_point(color = "red", size = 2) +
  annotate("text", label = "Event from 2013 to 2022", size = 4, x = 2, y = 325) +
  annotate("rect", xmin = 1, xmax = 4, ymin = 250, ymax = 317, alpha = .2) +
  labs(
    title = "Average house prices in the Netherlands",
    x = "Year",
    y = "Value"
  ) +
  theme_bw()