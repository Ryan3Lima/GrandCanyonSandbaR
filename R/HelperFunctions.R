library(xts) # Do I need this?
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
  # convert from cfs to cms
  cfs <- cms* 35.31468492103444
  # message if desired
  if (messages == TRUE){
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
#'
#'
#' @examples
#' cfs2cms(cfs = 8000, messages = TRUE)
#' cfs2cms(cfs = 10000, messages = FALSE)
#' @export
cfs2cms <- function(cfs, messages = FALSE){
  cms <- cfs/35.31468492103444
  if (messages == TRUE){
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
#' @examples
#' Qdat_formatted <- convertQdataRaw2FormattedQ(SampleQ_1week_raw)
#'
convertQdataRaw2FormattedQ <- function(Qdata, xcol_index = 4, DTcol_index = 3){
  formattedQ <- Qdata %>%
    dplyr::mutate(dateTime =as.POSIXct(.[[DTcol_index]], format = "%Y-%m-%d_%H%M", tz = "MST"))%>%
    dplyr::mutate(Discharge_cfs = .[[xcol_index]])%>%
    dplyr::mutate(Discharge_cms = cfs2cms(.[[xcol_index]])) %>%
    dplyr::select(dateTime,Discharge_cfs,Discharge_cms)
  return(formattedQ )
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
#' Qdat_Subset<-subsetDatetime(SampleQ_1week_processed,'20141003_0600', '20140109_1200')
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

#' Convert Data to XTS Object
#'
#' This function takes a data frame with a datetime column and one of two specified discharge columns,
#' and converts it into an `xts` object, which is suitable for time series analysis. The datetime column
#' is assumed to be named "dateTime" and should be in a format that can be converted to `POSIXct`.
#' The discharge data can be in cubic feet per second ("Discharge_cfs") or cubic meters per second ("Discharge_cms").
#'
#' @param data A data frame containing at least two columns: "dateTime" for the datetime of observations,
#' and either "Discharge_cfs" or "Discharge_cms" for discharge data. The "dateTime" column is converted
#' to `POSIXct` format if it is not already.
#' @param column_choice A string specifying which column to use for the discharge data.
#' Must be either "Discharge_cfs" or "Discharge_cms". Defaults to "Discharge_cfs".
#'
#' @return An `xts` object containing the selected discharge data indexed by the datetime of the observations.
#'
#' @examples
#' \dontrun{
#'   data <- data.frame(dateTime = Sys.time() + 0:4 * 3600,
#'                      Discharge_cfs = rnorm(5, mean = 100, sd = 10),
#'                      Discharge_cms = rnorm(5, mean = 2.83, sd = 0.28))
#'   xts_data <- convert_to_xts(data)
#'   print(xts_data)
#' }
#'
#' @importFrom xts xts
#' @export
#' @seealso \code{\link[xts]{xts}}, \code{\link[base]{as.POSIXct}}
convert_to_xts <- function(data, column_choice = "Discharge_cfs" ) {
  # Validate column choice
  if(!column_choice %in% c("Discharge_cfs", "Discharge_cms")) {
    stop("Invalid column choice. Choose either 'Discharge_cfs' or 'Discharge_cms'")
  }

  # Select the datetime and the chosen data column
  selected_data <- data[, c("dateTime", column_choice)]

  # Convert dateTime to POSIXct if not already
  if (!inherits(selected_data$dateTime, "POSIXct")) {
    selected_data$dateTime <- as.POSIXct(selected_data$dateTime)
  }

  # Create an xts object
  xts_data <- xts::xts(selected_data[, -1], order.by = selected_data$dateTime)

  return(xts_data)
}


#' Print Colored Messages to the Console
#'
#' This function prints messages to the R console with specified ANSI colors.
#' It's designed to help distinguish different types of messages (e.g., success, info, warning)
#' by color, making them more visually distinguishable.
#'
#' @param text The message text to be printed.
#' @param color A string specifying the color of the text. Supported colors include "green", "blue", and "red".
#' Default is "green".
#'
#' @details The function uses ANSI color codes to set the color of the text.
#' These codes are widely supported in modern terminals and R consoles, including RStudio.
#' However, some environments, particularly older Windows command lines, might not display
#' ANSI colors correctly. In such cases, the text will be printed without coloring.
#'
#' @examples
#' \dontrun{
#' printColored("Success message", "green")
#' printColored("Information message", "blue")
#' printColored("Error message", "red")
#' }
#'
#' @note While ANSI color codes are supported in many environments,
#' there's variability in support and appearance across different platforms and terminals.
#' Test the function in your target environment to ensure it works as expected.
#' Additionally, consider providing an option in your functions or scripts to disable colored output
#' for better compatibility across all environments.
#'
#' @export
printColored <- function(text, color = "green") {
  colors <- list(
    green = "\033[32m",
    blue = "\033[34m",
    red = "\033[31m",
    reset = "\033[0m"
  )

  color_code <- colors[[color]]
  reset_code <- colors$reset

  message(paste0(color_code, text, reset_code))
}
