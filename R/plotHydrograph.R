

convertQdataRaw2FormattedQ <- function(Qdata, xcol_index = 2, DTcol_index = 1){
  formattedQ <- Qdata %>%
    mutate(dateTime =as.POSIXct(.[[DTcol_index]], format = "%Y-%m-%d_%H%M", tz = "MST"))%>%
    mutate(Discharge_cfs = .[[xcol_index]])%>%
    mutate(Discharge_cms = .[[xcol_index]]/35.31468492103444)
    select(dateTime,Discharge_cfs, Dishcarge_cms)
  return(formattedQ )
}

FormattedQ2xts <- function(formattedQ,)

plotHydrograph <- function(Qdat,startDT, endDT, title, subtitle, unit = cfs){

}
