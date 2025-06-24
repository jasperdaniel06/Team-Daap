# Load the CSV
df_2023 <- read_csv2("bedrijvenNL2023.csv")
df_2019 <- read_csv2("bedrijvenNL2019.csv")

df_2023 <- as.data.frame(df_2023)
df_2019 <- as.data.frame(df_2019)



df_2023 <- df_2023[-c(13, 14), ]
df_2019 <- df_2019[-c(13, 14), ]


colnames(df_2023)[3] <- "Regio.s"
df_2023$Regio.s <- gsub(" \\(PV\\)", "", df_2023$Regio.s)
row.names(df_2023) <- df_2023$Regio.s
df_2023$Regio.s <- gsub("Fryslân", "Friesland", df_2023$Regio.s)

colnames(df_2019)[3] <- "Regio.s"
df_2019$Regio.s <- gsub(" \\(PV\\)", "", df_2019$Regio.s)
row.names(df_2019) <- df_2019$Regio.s
df_2019$Regio.s <- gsub("Fryslân", "Friesland", df_2019$Regio.s)



df_2019 <- inner_join(df_2023, df_2019, by = 'Regio.s')

busi <- c() # give variable busi the value of a vector

for(i in 1:nrow(df_2019))
{
  busi[i] = df_2019$"Vestigingen (Aantal).x"[i] / df_2019$"Vestigingen (Aantal).y"[i] # Element division  
}

df_2019 <- cbind(df_2019, busi) # add the dif variable to the data2 dataset




data2 <- inner_join(df_2019, data2, by = 'Regio.s')

data2 <- arrange(data2, busi)

busi <- sort(busi)

# made the data for the barplots
bottom <- mean(busi[1:4])
middle <- mean(busi[5:8])
top <- mean(busi[9:12])

bottom_woz <- mean(data2[1:4, 16])
middle_woz <- mean(data2[5:8, 16])
top_woz <- mean(data2[9:12, 16])

# Create the clean dataframe from your dataset
df <- data.frame(
  Province = data2[1:4, 3],
  Growth_Rate_New_Companies = data2[1:4, 8],
  WOZ_change = data2[1:4, 16]
)

# Pivot to long format
df_long <- pivot_longer(df, cols = c(Growth_Rate_New_Companies, WOZ_change),
                        names_to = "Type", values_to = "Value")

# Plot: side-by-side bars per province
ggplot(df_long, aes(x = Province, y = Value, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Growth of new companies and change in WOZ value per province \n(2019-2023, bottom 4)",
       x = "Province", y = "Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


df <- data.frame(
  Province = data2[5:8, 3],
  Growth_Rate_New_Companies = data2[5:8, 8],
  WOZ_change = data2[5:8, 16]
)

# Pivot to long format
df_long <- pivot_longer(df, cols = c(Growth_Rate_New_Companies, WOZ_change),
                        names_to = "Type", values_to = "Value")

# Plot: side-by-side bars per province
ggplot(df_long, aes(x = Province, y = Value, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Growth of new companies and change in WOZ value per province \n(2019-2023, middle 4)",
       x = "Province", y = "Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


df <- data.frame(
  Province = data2[9:12, 3],
  Growth_Rate_New_Companies = data2[9:12, 8],
  WOZ_change = data2[9:12, 16]
)

# Pivot to long format
df_long <- pivot_longer(df, cols = c(Growth_Rate_New_Companies, WOZ_change),
                        names_to = "Type", values_to = "Value")

# Plot: side-by-side bars per province
ggplot(df_long, aes(x = Province, y = Value, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Growth of new companies and change in WOZ value per province \n(2019-2023, top 4)",
       x = "Province", y = "Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



#test bar plot
data <- data.frame(
  Group = c("Bottom 4", "Middle 4", "Top 4"),
  Category = rep(c("Growth of New Companies", "Change in WOZ"), each = 3),
  Value = c(bottom, middle, top, bottom_woz, middle_woz, top_woz)
)

# Create the double bar plot
ggplot(data, aes(x = Group, y = Value, fill = Category)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Growth of New Companies and WOZ change for the 3 groups", 
       x = "Group", y = "Average Value", fill = "Category")