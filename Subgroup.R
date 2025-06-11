buzyness <- read.csv('buzyness.csv')
view(buzyness)
buzyness$Regio.s <- gsub('\\(PV\\)', '', buzyness$Regio.s)
library(dplyr)

buzyness <- buzyness %>%
  mutate(Regio.s = ifelse(Regio.s == "Fryslân", "Friesland", Regio.s))


# Check column names
colnames(buzyness)

# Look at some unique region names
unique(buzyness$Region.s)


library(dplyr)

buzyness <- buzyness %>%
  mutate(Regio.s = if_else(Regio.s == "Fryslân ", "Friesland ", Regio.s))

unique(buzyness$Regio.s)

library(dplyr)

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

library(ggplot2)
library(tidyr)

# Create the clean dataframe from your dataset
df <- data.frame(
  Province = data2$Regio.s,
  New_Companies = data2$`Nieuwe bedrijven`,
  WOZ_2020 = data2$`2020`
)

# Pivot to long format
df_long <- pivot_longer(df, cols = c(New_Companies, WOZ_2020),
                        names_to = "Type", values_to = "Value")

# Plot: side-by-side bars per province
ggplot(df_long, aes(x = Province, y = Value, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "New Companies and WOZ Value per Province (2020)",
       x = "Province", y = "Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

