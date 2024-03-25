# create sample discharge data

library(dataRetrieval)

site_id <- "09380000"
parameterCd <- "00060"
startDate <- "2014-10-03"
endDate <- "2014-10-10"

SampleQ_1week_raw <- dataRetrieval::readNWISuv(site_id, parameterCd, startDate, endDate)
SampleQ_1week_raw

usethis::use_data(SampleQ_1week_raw)

