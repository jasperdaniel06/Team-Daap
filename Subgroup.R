buzyness <- read.csv('buzyness.csv')
view(buzyness)
buzyness$Regio.s <- gsub('\\(PV\\)', '', buzyness$Regio.s)
library(dplyr)

buzyness <- buzyness %>%
  mutate(Regio.s = if_else(Regio.s == "Fryslân ", "Friesland ", Regio.s))

buzyness <- buzyness %>%
  rename(Bedrijfstak = "Bedrijfstakken.branches..SBI.2008.")
buzyness <- buzyness %>%
  rename('Nieuwe bedrijven' = 'Oprichtingen.van.vestigingen..aantal.')
  
buzyness <- filter(buzyness, Perioden == '2020', Bedrijfstak == 'A-U Alle economische activiteiten')
buzyness <- buzyness[-c(1, 14),]
buzyness$Regio.s <- gsub(' ', "", buzyness$Regio.s)

data2 <- inner_join(buzyness, data2, by = 'Regio.s')

unique(buzyness$Regio.s)

unique(data2$Regio.s)

library(ggplot2)
library(tidyr)
library(readr)
library(sf)


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



view(df_2023)
view(df_2019)

data2 <- inner_join(df_2019, data2, by = 'Regio.s')



# Create the clean dataframe from your dataset
df <- data.frame(
  Province = data2$Regio.s,
  Growth_Rate_New_Companies = data2$`busi`,
  WOZ_change = data2$`dif`
)

# Pivot to long format
df_long <- pivot_longer(df, cols = c(Growth_Rate_New_Companies, WOZ_change),
                        names_to = "Type", values_to = "Value")

# Plot: side-by-side bars per province
ggplot(df_long, aes(x = Province, y = Value, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Growth of new companies and change in WOZ value per province 2019-2023",
       x = "Province", y = "Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

