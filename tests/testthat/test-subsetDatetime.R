
data("SampleQ_1week_formatted")
head(SampleQ_1week_formatted)
startDate <- '20141003_1200'
stateDate2 <- '20141001_1200' # out of range
endDate2<-'20141012_1200' # out of range
endDate <- '20141008_1200'

test_that("EndDate out of range will trigger error",{expect_error(
          subsetDatetime(SampleQ_1week_formatted,startDT = startDate, endDT = endDate2))})

test_that("StartDate out of range will trigger error",{expect_error(
  subsetDatetime(SampleQ_1week_formatted,startDT2 = startDate, endDT = endDate))})
