
###########################################################################################################
### PROGRAM NAME: 01_DataCleaning.                                                                      ###
### DESCRIPTION:  Initial Exploration & Cleaning of IPUMS Data (2023)                                   ###
### DATE:         6/22/2025                                                                             ###
###########################################################################################################

#load necessary packages
library(tidyverse)
library(tidycensus)
library(tigris)

#loading pumas in NYC
nyc_pumas <- pumas(state = "NY", cb = TRUE, year = 2020) %>%
  filter(str_detect(NAMELSAD20, "NYC"))

#loading ipums variables
View(pums_variables)

ny_pums <- get_pums(
  variables = c("PUMA", "GRPIP", "RAC1P", "HISP", "HHT"),
  state = "NY",
    survey = "acs5",
  year = 2023,
  recode = TRUE)



#n_distinct(nyc_ipums$PUMA) #confirming that all 55 NYC PUMAs are present

