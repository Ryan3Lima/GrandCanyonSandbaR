# script to make GageList

library(googlesheets4)

GageList <-read_sheet('https://docs.google.com/spreadsheets/d/1ZMAO3szJ1MYXOCTYIHZ80M6rVPuaQv74th2ckHeRpQI/edit?usp=sharing')

usethis::use_data(GageList)
