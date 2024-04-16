# Load necessary libraries
library(ggplot2)
library(dygraphs)
library(rlang)
#' Plot an Interactive Hydrograph
#'
#' Creates an interactive hydrograph using the `dygraphs` package. This function
#' is designed to plot time series data of water discharge, allowing for the
#' specification of units in cubic feet per second (CFS) or cubic meters per second
#' (CMS). Additional parameters allow for customization of the plot title and subtitle.
#'
#' @param Qdat A time series object (preferably an xts object) containing the discharge
#' data to be plotted.
#' @param title The main title of the hydrograph plot. Default is "Hydrograph".
#' @param subtitle The subtitle of the hydrograph plot, typically used for specifying
#' the date range or other descriptive information. Default is "subtitle".
#' @param unit A character string specifying the unit of the discharge data. Supported
#' units are 'CFS' for cubic feet per second and 'CMS' for cubic meters per second.
#' Default is 'CFS'.
#'
#' @return An interactive hydrograph plot rendered using `dygraphs`.
#'
#' @examples
#' plotInteractiveHydrograph(Qdat = SampleQ_xts_cfs,
#'   title= "Colorado River Discharge at Lees Ferry",
#'   subtitle = "October 3rd 2014 - October 11th 2014")
#'
#'
#' @importFrom dygraphs dygraph dyAxis dyOptions dyRangeSelector
#' @export
plotInteractiveHydrograph <- function(Qdat,title = "Hydrograph", subtitle = "subtitle", unit = 'CFS'){
  fullTitle <- paste(title, "<br>", "<small>", subtitle, "</small>")
  if (unit == 'CFS'){
    lab = "Discharge (CFS)"
  } else if ((unit == 'CMS')){
    lab = "Discharge (CMS)"
  } else {
    stop("Something is wrong with your unit variable")
  }
  dygraphs::dygraph(Qdat, main = fullTitle) %>%
    dygraphs::dyAxis("y", label = lab) %>%
    dygraphs::dyOptions(useDataTimezone = TRUE) %>%
    dygraphs::dyRangeSelector(height = 20)
}

#' Plot a Static Hydrograph
#'
#' This function creates a static hydrograph using the ggplot2 package, allowing for
#' the visualization of water discharge over time in either cubic feet per second (CFS)
#' or cubic meters per second (CMS). The plot includes options to customize the title and subtitle.
#'
#' @param Qdat A dataframe containing the discharge data to be plotted.
#'             It must include a POSIXct `dateTime` column, and numeric `Discharge_cfs`
#'             and `Discharge_cms` columns.
#' @param title The main title of the hydrograph plot.
#'              Default is "Hydrograph".
#' @param subtitle The subtitle of the hydrograph plot, typically used for specifying
#'                 the date range or other descriptive information.
#'                 Default is "Enter subtitle here".
#' @param unit The unit of discharge data to be displayed.
#'             Valid options are 'CFS' for cubic feet per second and 'CMS' for cubic meters per second.
#'             Default is 'CFS'.
#'
#' @return A ggplot object representing the hydrograph.
#' @import ggplot2
#' @import rlang
#' @importFrom ggplot2 ggplot aes geom_line labs theme_minimal
#' @export
#'
#' @examples
#' plotStaticHydrograph(SampleQ_1week_processed, title = "Sample Hydrograph", subtitle = "Sample Data", unit = 'CFS')
plotStaticHydrograph <- function(Qdat, title = "Hydrograph", subtitle = "Enter subtitle here", unit = 'CFS') {

  # Select the appropriate discharge column based on the specified unit
  if (unit == 'CFS') {
    ylab <- "Discharge (CFS)"
    discharge_col <- "Discharge_cfs"
  } else if (unit == 'CMS') {
    ylab <- "Discharge (CMS)"
    discharge_col <- "Discharge_cms"
  } else {
    stop("Invalid unit specified. Choose either 'CFS' or 'CMS'")
  }

  # Convert the column name string to a symbol
  discharge_col_sym <- sym(discharge_col)

  # Create the plot using tidy evaluation
  p <- ggplot2::ggplot(Qdat, aes(x = dateTime, y = !!discharge_col_sym)) +
    ggplot2::geom_line() +  # Draw the line
    ggplot2::labs(title = title, subtitle = subtitle, y = ylab, x = "Time") +
    ggplot2::theme_minimal()  # Apply a minimalistic theme

  return(p)
}




#' Plot a Flow Duration Curve
#'
#' Creates a flow duration curve using the `ggplot2` package. This function is designed to plot
#' flow duration data from a given discharge dataset in either cubic feet per second (CFS)
#' or cubic meters per second (CMS). The curve represents the percentage of the time that certain
#' flows are equaled or exceeded during the period of record.
#'
#' @param Qdat A dataframe containing the discharge data to be plotted, expected to include
#'   a POSIXct dateTime column, and numeric Discharge_cfs and Discharge_cms columns.
#' @param unit A character string specifying the unit of the discharge data. Supported
#' units are 'CFS' for cubic feet per second and 'CMS' for cubic meters per second.
#' Default is 'CFS'.
#' @param title Optional: The main title of the flow duration curve. Default is "Flow Duration Curve".
#'
#' @return A ggplot object representing the flow duration curve.
#'
#' @examples
#' plotFlowDurationCurve(Qdat = SampleQ_1week_processed, unit = 'CMS', title = "Flow Duration Curve for Colorado River")
#'
#' @importFrom ggplot2 ggplot aes geom_line labs theme_minimal
#' @export
plotFlowDurationCurve <- function(Qdat, unit = 'CFS', title = "Flow Duration Curve") {

  # Select the appropriate discharge column based on the specified unit
  discharge_col <- ifelse(unit == 'CFS', "Discharge_cfs", "Discharge_cms")

  # Check if the selected discharge column exists in the dataframe
  if (!discharge_col %in% names(Qdat)) {
    stop("The specified unit does not match any discharge column in the dataframe.")
  }

  # Preparing data for flow duration curve
  # Sorting discharge values in descending order
  sorted_discharge <- Qdat[[discharge_col]][order(-Qdat[[discharge_col]])]

  # Calculating exceedance probabilities
  exceedance_probability <- (1:length(sorted_discharge) / length(sorted_discharge)) * 100

  # Creating a dataframe for plotting
  fdc_data <- data.frame(ExceedanceProbability = exceedance_probability, Discharge = sorted_discharge)

  # Plotting the flow duration curve
  p <- ggplot2::ggplot(fdc_data, aes(x = ExceedanceProbability, y = Discharge)) +
    ggplot2::geom_line() +  # Draw the line
    ggplot2::labs(title = title, x = "Exceedance Probability (%)", y = sprintf("Discharge (%s)", unit)) +
    ggplot2::theme_minimal()  # Apply a minimalistic theme

  return(p)
}




