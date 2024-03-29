# make sample data: SampleQ_xts_cfs and SampleQ_xts_cms
library(xts)

data("SampleQ_1week_formatted")

#set time zone
Sys.setenv(TZ='MST')


# Load necessary libraries
library(xts)
library(dygraphs)

data('SampleQ_1week_formatted')

# subset the CFS data
selected_data <- SampleQ_1week_formatted %>%
  select(dateTime,Discharge_cfs)
# subset the CMS data
selected_data_cms <- SampleQ_1week_formatted %>%
  select(dateTime,Discharge_cms)
# convert to xts
SampleQ_xts_cms <- xts(selected_data_cms[, -1, drop = FALSE], order.by = selected_data_cms$dateTime)
usethis::use_data(SampleQ_xts_cms)
# convert to xts
SampleQ_xts_cfs <- xts(selected_data[, -1, drop = FALSE], order.by = selected_data$dateTime)
usethis::use_data(SampleQ_xts_cfs)
