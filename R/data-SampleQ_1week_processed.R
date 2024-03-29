#' Sample processed or Formatted Discharge Data for one week
#'
#'A dataset containing formatted using convertQdataRaw2FormattedQ() from HelperFunctions.R discharge measurements for a specific USGS site
#' over a one-week period from October 3, 2014, to October 10, 2014. Data was
#' retrieved using the \code{\link[dataRetrieval]{readNWISuv}} function from
#' the \pkg{dataRetrieval} package.
#'
#'
#' @format A data frame with 168 observations on the following 3 variables:
#' \describe{
#'   \item{\code{dateTime}}{A POSIXct date-time indicating the time of the measurement.}
#'   \item{\code{Discharge_cfs}}{Numeric streamflow data, measured in cubic feet per second (cfs).}
#'   \itme{\code{Discharge_cms}}{Numeric streamflow data, measured in cubic meters per second (cms)}
#'}
#' @source USGS National Water Information System
#' @references
#' \url{https://waterdata.usgs.gov/nwis}
#' @keywords datasets
#' @name SampleQ_1week_processed
#' @docType data
#' @usage data(SampleQ_1week_formatted)
"SampleQ_1week_raw"
