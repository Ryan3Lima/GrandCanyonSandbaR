#' Stage Discharge Grids
#'
#' A dataset containing the stage discharge relationship modeled
#' by a Bayesian power law model for multiple sites.
#' This dataset is used internally by `findQ_from_WSE` and `findWSE_from_Q` functions.
#'
#' @format A list of data frames where each data frame corresponds to a site and contains
#'   columns:
#'   - \code{Elevation}: Elevation in meters.
#'   - \code{CMS_lower}: Lower bound of discharge in cubic meters per second.
#'   - \code{CMS_median}: Median of discharge in cubic meters per second.
#'   - \code{CMS_upper}: Upper bound of discharge in cubic meters per second.
#'   - \code{CFS_lower}: Lower bound of discharge in cubic feet per second.
#'   - \code{CFS_median}: Median of discharge in cubic feet per second.
#'   - \code{CFS_upper}: Upper bound of discharge in cubic feet per second.
#'
#' @details To access the stage discharge grids for a specific site, use the syntax:
#' \code{StageDischargeGrids[[sitename]]}, where \code{sitename} is one of the items in the
#' \code{SandbarSites} dataframe. This dataframe lists all sites for which stage discharge
#' relationships are available and modeled.
"StageDischargeGrids"
