library(tidyverse)
library(cbsodataR)
library(sf)

cbs_maps <- cbs_get_maps()
# the layout of the data.frame is:
str(cbs_maps)

provincie_2020 <- cbs_get_sf("provincie", 2020)
str(provincie_2020) # sf object