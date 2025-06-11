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

