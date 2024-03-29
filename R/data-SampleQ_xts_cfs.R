#' SampleQ_xts_cfs: Discharge in cubic feet per second
#'
#' A dataset containing observations of discharge in cubic feet per second (cfs)
#' from the same location and period as `SampleQ_xts_cms`. Formatted as an xts
#' object for time series analysis.
#'
#' @format An object of class \code{xts} with 768 rows and 1 column:
#' \describe{
#'   \item{\code{Discharge_cfs}}{Numeric vector of discharge values in cubic feet per second.}
#' }
#' @source Same as `SampleQ_xts_cms`.
#' @examples
#' data(SampleQ_xts_cfs)
#' plot(SampleQ_xts_cfs)
