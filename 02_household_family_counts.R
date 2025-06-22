
###########################################################################################################
### PROGRAM NAME: Fatherhood Estimate                                                                   ###
### DESCRIPTION:  Generating Frequencies for Initial Analysis Table                                     ###
### ANALYST:      Natalie Brown                                                                         ###
### DATE:         6/18/2025                                                                             ###
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
IPUMS.path= '//Chgoldfs/dmhhs/CIDI Staff/Projects/Fatherhood Initiative/Fatherhood 2025/census data/'

#bring in data
#nyc_ipums_2023 <- read.csv(paste0(IPUMS.path, 'nyc_ipums_2023.csv'))

nyc_ipums %>% group_by(SAMPLE, CBSERIAL) %>% summarise(n = n()) #number of households

nyc_ipums %>% group_by(SAMPLE, CBSERIAL, MULTGEN) %>% summarise(n = n()) # number of multi-generational families 

nyc_ipums %>% 
  group_by(SAMPLE, CBSERIAL, HHTYPE) %>% 
  summarise(n = n()) %>%
  filter(HHTYPE == 4|HHTYPE == 5|HHTYPE == 6|HHTYPE == 7) #number of non-family households

nyc_ipums %>% group_by(SAMPLE, CBSERIAL, HHTYPE) %>% summarize(n = n()) %>% filter(HHTYPE == 4) #number of households with single male HH

nyc_ipums %>% group_by(SAMPLE, CBSERIAL, HHTYPE, ELDCH) %>% summarise(n = n()) %>%  #number of families w/ a minor child 
  filter(HHTYPE == 1|HHTYPE == 2|HHTYPE == 3,
         ELDCH < 18)

nyc_ipums %>% group_by(SAMPLE, CBSERIAL, HHTYPE, ELDCH) %>% summarise(n = n()) %>%  #number of families w/ a minor child by HHTYPE
  filter(HHTYPE == 1|HHTYPE == 2|HHTYPE == 3, ELDCH < 18) %>% group_by(HHTYPE) %>% summarise(n = n())

nyc_ipums %>% group_by(SAMPLE, CBSERIAL, HHTYPE) %>% summarise(n = n()) %>% # of families by age of children
  group_by(HHTYPE) %>% summarise(n = n())

nyc_ipums %>% group_by(SAMPLE, CBSERIAL, HHTYPE, NCHLT5) %>% summarise(n = n()) %>%  #number of families w/ a minor child by HHTYPE
  filter(HHTYPE == 1|HHTYPE == 2|HHTYPE == 3, NCHLT5 != 0)
  

