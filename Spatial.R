library(tidyverse)
library(cbsodataR)
library(sf)

cbs_maps <- cbs_get_maps()
# the layout of the data.frame is:
str(cbs_maps)

provincie_2020 <- cbs_get_sf("provincie", 2020)
str(provincie_2020) # sf object


data2$Regio.s <- row.names(data2)
colnames(provincie_2020)[2] <- "Regio.s"
data2$Regio.s <- gsub(" \\(PV\\)", "", data2$Regio.s)
data2$Regio.s <- gsub("Fryslân", "Friesland", data2$Regio.s)
data2 <- inner_join(provincie_2020, data2, by = 'Regio.s')


# Create the map using ggplot2
ggplot(data2) +
  geom_sf(aes(fill = `2020`)) +  # Mapping values from the 2020 column
  scale_fill_gradient(low = "blue", high = "red") +
  theme_minimal() +
  labs(title = "Map of House prices per region", fill = "House prices in 2020\nx1000 in euros")

# Create the map using ggplot2
ggplot(data2) +
  geom_sf(aes(fill = `2023`)) +  # Mapping values from the 2020 column
  scale_fill_gradient(low = "blue", high = "red") +
  theme_minimal() +
  labs(title = "Map of House prices per region", fill = "House prices in 2023\nx1000 in euros")


