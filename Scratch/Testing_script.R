# testing script - scratch
# setup

library(dataRetrieval)
library(xts)
library(dygraphs)
library(tidyverse)
library(googlesheets4)


#### Load gage data

GageList <-read_sheet('https://docs.google.com/spreadsheets/d/1ZMAO3szJ1MYXOCTYIHZ80M6rVPuaQv74th2ckHeRpQI/edit?usp=sharing')

# read gage data for gages

LeesFerry_Q <- as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306120450.tsv"))
ThirtyMile_Q <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306120852.tsv"))
LCR_Q <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306121200.tsv"))
Phantom_Q <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306121809.tsv"))
National_Q <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306122225.tsv"))
Diamond_Q <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306122518.tsv"))





