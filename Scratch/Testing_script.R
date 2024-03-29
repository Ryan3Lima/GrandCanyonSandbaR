# testing script - scratch
# setup

# Max - adding these imports the description, if you want to include them
# # I added all of these to imports
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
# GageList <- googlesheets4::read_sheet('https://docs.google.com/spreadsheets/d/1ZMAO3szJ1MYXOCTYIHZ80M6rVPuaQv74th2ckHeRpQI/edit?usp=sharing')
# Max- I got denied permission from downloading this sheet - I don't know how to give out tokens

# # read gage data for gages
# Max - One trick that I found is that you can copy and paste file paths and wrap it
# with the tag r"(C:\Filepath\file.csv)" that way you don't have to worry about escape characters
#LeesFerry_Qdata_raw <- as_tibble(read_tsv(r"(C:\PackageDev\GrandCanyonSandbaR-Review\data-raw\gcmrc20240306120450.tsv)"))
# or using a relative path - which is a little trickier depending on the the current directory
#getwd()
# LeesFerry_Qdata_raw <- as_tibble(read_tsv("data-raw/gcmrc20240306120450.tsv"))
#
# convertQdataRaw2FormattedQ(LeesFerry_Qdata_raw)
# # Max - I'm not sure how you plan to subset the data, do you want to subset it first by time and then change it to 'cfs' or 'cms'
# # depending on the situation. Maybe filtering it by "time" and "cfs" if that is going to be consistent within the raw data columns
# # For example, with regular expressions you can search strings for a matching case
#
# timeColumnIndex <- grep("time", colnames(LeesFerry_Qdata_raw), ignore.case = T) # Gives you the index of the column
# timeColumnString <- grep("time", colnames(LeesFerry_Qdata_raw), ignore.case = T, value = T) # Gives you string of the column
# dischargeColumnIndex <- grep("cfs", colnames(LeesFerry_Qdata_raw), ignore.case = T)
# dischargeColumnString <- grep("cfs", colnames(LeesFerry_Qdata_raw), ignore.case = T, value = T)
#
# # Subset the data based on the columns you want
# LeesFerry_Filtered <- LeesFerry_Qdata_raw[c(timeColumnIndex,dischargeColumnIndex)]
#
# #LeesFerry_Qdata_raw <- as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306120450.tsv"))
#
# ThirtyMile_Qdata_raw <-as_tibble(read_tsv("data-raw/gcmrc20240306120852.tsv"))
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

