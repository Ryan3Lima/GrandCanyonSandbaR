# testing script - scratch
# setup

# library(dataRetrieval)
# library(xts)
# library(dygraphs)
# library(tidyverse)
# library(googlesheets4)
# library(lubridate)
#
#
# #### Load gage data
#
# GageList <-read_sheet('https://docs.google.com/spreadsheets/d/1ZMAO3szJ1MYXOCTYIHZ80M6rVPuaQv74th2ckHeRpQI/edit?usp=sharing')
#
# # read gage data for gages
#
# LeesFerry_Qdata_raw <- as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306120450.tsv"))
# ThirtyMile_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306120852.tsv"))
# LCR_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306121200.tsv"))
# Phantom_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306121809.tsv"))
# National_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306122225.tsv"))
# Diamond_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306122518.tsv"))
#
#
# LeesFerryQ <- LeesFerry_Qdata_raw %>%
#   mutate(dateTime = `time (MST)`)%>%
#   mutate(Discharge_cfs = `Discharge(cfs)-09380000`)%>%
#   mutate(Discharge_cms = cfs2cms(`Discharge(cfs)-09380000`)) %>%
#   select(dateTime,Discharge_cfs,Discharge_cms)

