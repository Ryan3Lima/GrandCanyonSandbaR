#' Plot an Interactive Hydrograph
#'
#' Creates an interactive hydrograph using the `dygraphs` package. This function
#' is designed to plot time series data of water discharge, allowing for the
#' specification of units in cubic feet per second (cfs) or cubic meters per second
#' (cms). Additional parameters allow for customization of the plot title and subtitle.
#'
#' @param Qdat A time series object (preferably an xts object) containing the discharge
#' data to be plotted.
#' @param title The main title of the hydrograph plot. Default is "Hydrograph".
#' @param subtitle The subtitle of the hydrograph plot, typically used for specifying
#' the date range or other descriptive information. Default is "subtitle".
#' @param unit A character string specifying the unit of the discharge data. Supported
#' units are 'cfs' for cubic feet per second and 'cms' for cubic meters per second.
#' Default is 'cfs'.
#'
#' @return An interactive hydrograph plot rendered using `dygraphs`.
#'
#' @examples
#' \dontrun{
#' data("SampleQ_xts_cfs")
#' plotInteractiveHydrograph(Qdat = SampleQ_xts_cfs,
#'   title= "Colorado River Discharge at Lees Ferry",
#'   subtitle = "October 3rd 2014 - October 11th 2014")
#' }
#'
#' @importFrom dygraphs dygraph dyAxis dyOptions dyRangeSelector
#' @export
#' @rdname plotInteractiveHydrograph
plotInteractiveHydrograph <- function(Qdat,title = "Hydrograph", subtitle = "subtitle", unit = 'cfs'){
  fullTitle <- paste(title, "<br>", "<small>", subtitle, "</small>")
  if (unit == 'cfs'){
    lab = "Discharge (CFS)"
  } else if ((unit == 'cms')){
    lab = "Discharge (CmS)"
  } else {
    stop("Something is wrong with your unit variable")
  }
  dygraphs::dygraph(Qdat, main = fullTitle) %>%
    dygraphs::dyAxis("y", label = lab) %>%
    dygraphs::dyOptions(useDataTimezone = TRUE) %>%
    dygraphs::dyRangeSelector(height = 20)
}


