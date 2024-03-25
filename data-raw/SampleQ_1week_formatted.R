# create sample discharge data

library(dataRetrieval)
library(magrittr)
library(dplyr)

site_id <- "09380000"
parameterCd <- "00060"
startDate <- "2014-10-03"
endDate <- "2014-10-10"

SampleQ_1week_raw <- dataRetrieval::readNWISuv(site_id, parameterCd, startDate, endDate)

internal_Raw2FormattedQ <- function(Qdata, xcol_index = 4, DTcol_index = 3){
  formattedQ <- Qdata %>%
    dplyr::mutate(dateTime =base::as.POSIXct(.[[DTcol_index]], format = "%Y-%m-%d_%H%M", tz = "MST"))%>%
    dplyr::mutate(Discharge_cfs = .[[xcol_index]])%>%
    dplyr::mutate(Discharge_cms = cfs2cms(.[[xcol_index]])) %>%
    dplyr::select(dateTime,Discharge_cfs,Discharge_cms)
  return(formattedQ )
}

SampleQ_1week_formatted <-internal_Raw2FormattedQ(SampleQ_1week_raw)

usethis::use_data(SampleQ_1week_formatted, overwrite = TRUE)

