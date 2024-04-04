#' Gage List Data
#'
#' This dataset contains information about various gaging stations, including their IDs, names, river mile numbers, data file paths, data sources, start dates of the data, lag slopes, and lag intercepts. The data was imported from a Google Sheets document as part of the package data preparation process.
#'
#' @format A data frame with 6 rows and 8 columns:
#' \describe{
#'   \item{\code{SiteID}}{Character vector of site IDs.}
#'   \item{\code{GageNameStr}}{Character vector of gage names.}
#'   \item{\code{RiverMileNum}}{Numeric vector of river mile numbers.}
#'   \item{\code{GageDataFile}}{Character vector of paths to gage data files.}
#'   \item{\code{GageDataSrc}}{Character vector of URLs for the gage data sources.}
#'   \item{\code{DataStartDate}}{Datetime vector of the start dates for the data.}
#'   \item{\code{LagSlope}}{List of slopes from lagtime  analysis.}
#'   \item{\code{LagIntercept}}{List of intercepts from lagtime analysis.}
#' }
#' @source Data imported from Google Sheets.
"GageList"
