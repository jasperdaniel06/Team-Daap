library(tidyverse)
library(cbsodataR)
library(sf)

cbs_maps <- cbs_get_maps()
# the layout of the data.frame is:
str(cbs_maps)

provincie_2020 <- cbs_get_sf("provincie", 2020)
str(provincie_2020) # sf object
View(provincie_2020)


data2$Regio.s <- row.names(data2)
colnames(provincie_2020)[2] <- "Regio.s"
data2$Regio.s <- gsub(" \\(PV\\)", "", data2$Regio.s)
data2$Regio.s <- gsub("Fryslân", "Friesland", data2$Regio.s)
data2 <- inner_join(provincie_2020, data2, by = 'Regio.s')

