
library(xts)
#' Converts values from Cubic Meters per second to Cubic feet per second
#'
#' @param cms numeric value for cubic meters per second
#' @param messages Boolean TRUE or FALSE; default = FALSE, use messages = T to get more information
#'
#' @return numeric value for cubic feet per second
#' @export
#'
#' @examples
#' cms2cfs(cms = 227, messages = TRUE)
#' cms2cfs(cms = 445, messages = FALSE)
cms2cfs <- function(cms, messages = FALSE){
  cfs <- cms* 35.31468492103444
  if(messages){
    print(paste0("Converting ",cms," -- Cubic Meters per second to Cubic feet per second by multiplying 35.31468492103444" ))
    print(paste0("result =[", cfs,"] Cubic Feet Per Second"))
  }
  return(cfs)
}

#' Converts values from Cubic Feet per second to Cubic meters per second
#'
#' @param cfs numeric value for cubic feet per second
#' @param messages Boolean TRUE or FALSE; default = FALSE, use messages = T to get more information
#'
#' @return numeric value for cubic meters per second
#' @export
#'
#' @examples
#' cfs2cms(cfs = 8000, messages = TRUE)
#' cfs2cms(cfs = 10000, messages = FALSE)
cfs2cms <- function(cfs, messages = FALSE){
  cms <- cfs/35.31468492103444
  if(messages){
    print(paste0("Converting ",cfs," -- Cubic feet per second to Cubic meters per second by dividing by 35.31468492103444" ))
    print(paste0("result =[", cms,"] Cubic Meters Per Second"))
  }
  return(cms)
}

#' Process NWIS gage data, remove unwanted columns, create CFS column, change column names
#' @importFrom magrittr "%>%"
#'
#' @param Qdata data.frame or tibble. from NWIS instantaneous values for discharge (Q)
#' @param xcol_index numeric. default = 4; Provide the index for the column containing discharge (cfs)
#' @param DTcol_index numeric. default = 3; Provide the index for the column containing time stamp or datetime
#'
#' @return xts object
#' @export
#'
#' @examples
#' Qdat_formatted <- convertQdataRaw2FormattedQ(SampleQ_1week_raw)
convertQdataRaw2FormattedQ <- function(Qdata, xcol_index = 4, DTcol_index = 3){
  formattedQ <- Qdata %>%
    dplyr::mutate(dateTime = as.POSIXct(.[[DTcol_index]], format = "%Y-%m-%d_%H%M", tz = "MST"))%>%
    dplyr::mutate(Discharge_cfs = .[[xcol_index]])%>%
    dplyr::mutate(Discharge_cms = cfs2cms(.[[xcol_index]])) %>%
    dplyr::select(dateTime,Discharge_cfs,Discharge_cms)
  return(formattedQ)
}


#' Subset discharge data with two timestamps 'YYYYMMDD_HHMM'
#'
#' @param formattedQ formatted tibble, output of ConvertQdataRaw2FormattedQ
#' @param startDT String. Starting time stamp 'YYYYMMDD_HHMM' ex: '20200101_2315'
#' @param endDT String. Ending time stamp 'YYYYMMDD_HHMM' ex: '20220101_2120'
#'
#' @return tibble or data.frame subset by startDT and endDT
#' @export
#' @examples
#' Qdat_Subset<-subsetDatetime(SampleQ_1week_formatted,'20141003_0600', '20140109_1200')
subsetDatetime <- function(formattedQ, startDT, endDT){
  startDT_posix <- as.POSIXct(startDT, format = "%Y%m%d_%H%M", tz = "MST")
  endDT_posix <- as.POSIXct(endDT, format = "%Y%m%d_%H%M", tz = "MST")
  if (startDT_posix < min(formattedQ$dateTime)){
    stop('startDT is out of range')
  } else {print("startDT in range")}
  if(endDT_posix > max(formattedQ$dateTime)){
    stop('endDT is out of range')
  } else {print('endDT is in range')}
  df <- subset(formattedQ, dateTime >= startDT_posix & dateTime <= endDT_posix)
  print(paste0("Dataset successfully subset from:",startDT_posix, " to: ", endDT_posix))
  return(df)
}

#' Turn Formatted discharge data into an xts time-series object for plotting with dygraph
#'
#' @param formattedQ data.frame or tibble. formatted data (or subset and formatted data) output from convertQdataRaw2FormattedQ()
#' @param unit string. default unit = 'cfs', can also be unit = 'cms'
#'
#' @return xts time series object
#' @export
#'
#' @examples
#' Qdat_xts_cfs <- FormattedQ2xts(SampleQ_1week_formatted)
#' Qdat_xts_cms <- FormattedQ2xts(SampleQ_1week_formatted, unit='cms')
FormattedQ2xts <- function(formattedQ, unit = 'cfs') {
  # Max - You could check the column names for "cfs" or "cms"
  # Looks for unit string in the columns and returns the name of the column
  if(any(grep(unit, names(formattedQ), ignore.case = T))){
    print(paste0("Found '",unit,"'column"))
    columnName <- grep("cfs", names(formattedQ), value = T) # Max - You could pass this string into the required columns step
  }else{
    # Force the format to be the unit
    stop(paste("Could not find column '", unit,"' in input object."))
  }
  dateTime <- "dateTime"
  if(any(grep(dateTime, names(formattedQ), ignore.case = T))){
    print(paste0("Found '",dateTime,"' column"))
    dateTimeColumn <- grep(dateTime, names(formattedQ), value = T) # Max - You could pass this string into the required columns step
  }else{
    # Force the format to be the unit
    stop(paste("Could not find a '", dateTime,"' in input object."))
  }
  # Max - you could add a try step to get the 'cms' or 'cfs' if you can't find the
  # desired unit
  # try("cfs"), else try("cms") # not real code
  Qdat <- xts::xts(x= formattedQ[columnName], order.by = formattedQ[[dateTimeColumn]])

  # if (!unit %in% c("cfs", "cms")) {
  #   stop("Unit must be 'cfs' or 'cms'")
  # }
  #
  # # Check if necessary columns exist in formattedQ
  # requiredCols <- c("dateTime")
  # if(unit == 'cms') {
  #   requiredCols <- c(requiredCols, "Discharge_cms")
  # } else {
  #   requiredCols <- c(requiredCols, "Discharge_cfs")
  # }
  #
  # if (!all(requiredCols %in% names(formattedQ))) {
  #   stop(paste("Missing required columns:", paste(requiredCols[!requiredCols %in% names(formattedQ)], collapse=", ")))
  # }
  #
  # # Select appropriate discharge column based on the unit
  # dischargeColumn <- if(unit == 'cms'){formattedQ$Discharge_cms} else{formattedQ$Discharge_cfs}
  #
  # Qdat <- xts::xts(x= dischargeColumn, order.by = formattedQ$dateTime)

  return(Qdat)
}

