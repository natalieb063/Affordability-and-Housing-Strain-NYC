#run package 01 first

#load necessary packages
library(tidyverse)
library(tidycensus)
library(tigris)
library(tmap)

#local settings
options(scipen=999)

#data exploration

nyc_pums %>% count(wt = PWGTP) #raw estimate of total New Yorkers, a slight overestimate

nyc_pums %>% filter(race_ethnicity != "Mixed or Other") %>%
  group_by(race_ethnicity) %>%
  summarize(ARB_above_30 = sum(WGTP[GRPIP >= 30]) / sum(WGTP),
            ARB_above_40 = sum(WGTP[GRPIP >= 40]) / sum(WGTP),
            ARB_above_60 = sum(WGTP[GRPIP >= 60]) / sum(WGTP)) #ARB = annual rent burden

#For annual rent burdens above 30, 40, and 60, Hispanic/Latine New Yorkers have
#the largest population composition, followed by Black residents 

hisp_map_data <- nyc_pums %>%
  group_by(race_ethnicity, PUMA) %>%
  summarize(
    ARB_above_30 = 100 * (sum(WGTP[GRPIP >= 30]) / sum(WGTP))) %>%
  filter(race_ethnicity == "Hispanic/Latine")

slice_max(hisp_map_data, order_by = ARB_above_30, n = 5)
#1 Highbridge & Concourse (BX)
#2 Fordham, Bedford Park, & Norwood (MN)
#3 Morris Heights & Mount Hope (BX)
#4 Bensonhurst & Bath Beach (BK)
#5 Morrisania, Tremont, Belmont, & West Farms (BX)

library(tmap)

joined_pumas <- nyc_pumas %>%
  left_join(hisp_map_data, by = c("PUMACE20" = "PUMA"))

tm_shape(joined_pumas) + 
  tm_polygons(col = "ARB_above_30", 
              palette = "Blues",
              title = "% Rent-Burdened\ Hispanic households") + 
  tm_layout(legend.outside = TRUE,
            legend.outside.position = "right")

black_map_data <- nyc_pums %>%
  group_by(race_ethnicity, PUMA) %>%
  summarize(
    ARB_above_30 = 100 * (sum(WGTP[GRPIP >= 30]) / sum(WGTP))) %>%
  filter(race_ethnicity == "Black")

slice_max(black_map_data, order_by = ARB_above_30, n = 5)
#1 Melrose, Mott Haven, Longwood, & Hunts Point (BX)
#2 Lower East Side & Chinatown PUMA (MN)
#3 Fordham, Bedford Park, & Norwood (MN)
#4 Morris Heights & Mount Hope (BX)
#5 Financial District & Greenwich Village (MN)

tm_shape(joined_pumas) + 
  tm_polygons(col = "ARB_above_30", 
              palette = "Reds",
              title = "% Rent-Burdened\ Black households") + 
  tm_layout(legend.outside = TRUE,
            legend.outside.position = "right")
