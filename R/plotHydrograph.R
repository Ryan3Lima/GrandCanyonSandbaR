

# plotInteractiveHydrograph <- function(Qdat,title = "Hydrograph", subtitle = "subtitle", unit = 'cfs'){
#   fullTitle <- paste(title, "<br>", "<small>", subtitle, "</small>")
#   if (unit == 'cfs'){
#     lab = "Discharge (CFS)"
#   } else if ((unit == 'cms')){
#     lab = "Discharge (CmS)"
#   } else {
#     stop("Something is wrong with your unit variable")
#   }
#   dygraph(Qdat, main = fullTitle) %>%
#     dyAxis("y", label = lab) %>%
#     dyOptions(useDataTimezone = TRUE) %>%
#     dyRangeSelector(height = 20)
# }

# df1 <- convertQdataRaw2FormattedQ(LeesFerry_Qdata_raw)
# df_sub <-subsetDatetime(df1,'20200101_0000', '20210101_0000')
# df_sub
# df_xts <- FormattedQ2xts(df_sub)
# plotInteractiveHydrograph(df_xts)
#
# df2 <- convertQdataRaw2FormattedQ()

