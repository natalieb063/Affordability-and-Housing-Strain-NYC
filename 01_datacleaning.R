
###########################################################################################################
### PROGRAM NAME: Fatherhood Estimate                                                                   ###
### DESCRIPTION:  Initial Exploration & Cleaning of IPUMS Data (2023)                                   ###
### ANALYST:      Natalie Brown                                                                         ###
### DATE:         5/30/2025                                                                              ###
###########################################################################################################

#options(download.file.method = "wininet")

#load necessary packages
library('tidyverse')
library('janitor')
library('dplyr')
library('lubridate')
library('haven')
library('data.table')
library('reshape2')
library('gmodels')
library("fastLink")
library(readxl)

#set the path for the data files. 
IPUMS.path= '//Chgoldfs/dmhhs/CIDI Staff/Projects/Fatherhood Initiative/Fatherhood 2025/census data/IPUMS_extract/'
PUMAs.path = '//Chgoldfs/dmhhs/CIDI Staff/Projects/Fatherhood Initiative/Fatherhood 2025/census data/'

#bring in data
ipums_2023 <- read.csv(paste0(IPUMS.path, 'usa_00003.csv'))
#pumas_2020 <- read.csv(paste0(PUMAs.path, 'PUMA2010_2020_crosswalk.csv'))

nyc_ipums <- ipums_2023 %>% filter(PUMA %in% pumas_2020$PUMA20)

n_distinct(nyc_ipums$PUMA) #confirming that all 55 NYC PUMAs are present

write.csv(nyc_ipums, "nyc_ipums_2023.csv")

#rm(ipums_2023)

#frequencies 

nyc_ipums %>% group_by(MULTYEAR) %>% summarize(n = n())

nyc_ipums %>% group_by(HHTYPE) %>% summarize(n = n())

nyc_ipums %>% filter(POVERTY <= 300) %>% group_by(POVERTY) %>% summarize(n = n())

nyc_ipums %>% group_by(POPLOC) %>% summarize(n = n())

n_distinct(nyc_ipums$PUMA)

unique(nyc_ipums$PUMA)
