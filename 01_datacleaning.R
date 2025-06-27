
###########################################################################################################
### PROGRAM NAME: 01_DataCleaning.                                                                      ###
### DESCRIPTION:  Initial Exploration & Cleaning of IPUMS Data (2023)                                   ###
### DATE:         6/22/2025                                                                             ###
###########################################################################################################

#load necessary packages
library(tidyverse)
library(tidycensus)
library(tigris)
library(tmap)

#local settings
options(scipen=999)

#loading pumas in NYC
nyc_pumas <- pumas(state = "NY", cb = TRUE, year = 2020) %>%
  filter(str_detect(NAMELSAD20, "NYC"))

nyc_pumas_vec <- nyc_pumas$PUMACE20

#loading ipums variables
View(pums_variables)

ny_pums <- get_pums(
  variables = c("PUMA", "GRPIP", "RAC1P", "HISP", "HHT"),
  state = "NY",
    survey = "acs5",
  year = 2023,
  recode = TRUE)

#filtering to pumas in NYC
nyc_pums <- ny_pums %>%
  filter(PUMA %in% nyc_pumas_vec)

#generating race and ethnicity variables
nyc_pums <- nyc_pums %>%
  mutate(race_ethnicity = case_when(HISP != "01" ~ "Hispanic/Latine",
                                    HISP == "01" & RAC1P == "1" ~ "White",
                                    HISP == "01" & RAC1P == "2" ~ "Black",
                                    HISP == "01" & RAC1P == "3" ~ "American Indian/Alaska Native",
                                    HISP == "01" & RAC1P == "4" ~ "American Indian/Alaska Native",
                                    HISP == "01" & RAC1P == "5" ~ "American Indian/Alaska Native",
                                    HISP == "01" & RAC1P == "6" ~ "AAPI",
                                    HISP == "01" & RAC1P == "7" ~ "AAPI",
                                    HISP == "01" & RAC1P == "8" ~ "Mixed or Other",
                                    HISP == "01" & RAC1P == "9" ~ "Mixed or Other",
                                    TRUE ~ "Mixed or Other"))

