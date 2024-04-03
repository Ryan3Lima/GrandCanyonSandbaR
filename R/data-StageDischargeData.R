#' Stage-Discharge Data for Sandbar Sites
#'
#' This dataset contains stage-discharge data for various sandbar sites. It has been preprocessed to convert discharge measurements from cubic feet per second (cfs) to cubic meters per second (cms) and to select relevant variables for fitting a generalized power law model using the `bdrc` package. The data is structured as a list, with each element representing a different sandbar site identified by its unique code.
#'
#' @format A list of 39 data frames, each containing the following variables:
#' \describe{
#'   \item{W}{Elevation (meters).}
#'   \item{Q}{Discharge (cubic meters per second).}
#'   \item{Qcfs}{Discharge (cubic feet per second), as originally recorded.}
#' }
#' Each data frame corresponds to a specific sandbar site, with names like `RC0034Lsd`, `RC2255Rsd`, etc., where the naming convention is `RC{sitecode}sd`.
#'
#' @source Describe the source of your original data here. If the data is from a public dataset, include a citation or a URL where the data can be found. If the data was collected by your research team, provide a brief description of the methodology used to collect the data.
#' @name StageDischargeData
#' @usage
#' data(StageDischargeData)
#'
#' @examples
#' data(StageDischargeData)
#' head(StageDischargeData[[1]]) # View the first few rows of the first site's data
#'
#' @details
#' The `convert2_bdrc_format` function was used to preprocess each site's data. This function is part of the package and performs the following transformations:
#' - Converts discharge from cubic feet per second (cfs) to cubic meters per second (cms).
#' - Renames the `Elevation` column to `W` for compatibility with `bdrc::gplm.fit`.
#' - Selects only the relevant columns (`W`, `Q`, `Qcfs`) for analysis.
#'
#' @export
StageDischargeData
