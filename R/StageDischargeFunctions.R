#' @importFrom dplyr %>%
#' @importFrom bdrc gplm
#' @importFrom graphics plot
#' @importFrom stats setNames
#' @importFrom utils data
NULL

#' Validate Site Name
#'
#' Checks if the provided site name is valid by verifying its presence in the `SandbarSites` dataset.
#'
#' @param sitename A character string of the site name to validate.
#' @return None; this function stops execution with an error message if the site name is invalid.
#' @examples
#' \dontrun{
#'   validSite("0034L") # Assumes "0034L" is a valid site in SandbarSites
#' }
#' @export
validSite <- function(sitename){
  if(!sitename %in% SandbarSites) {
    stop("Invalid Sitename")
  }
}

#' Fit Generalized Power Law Model
#'
#' Fits a generalized power law model to stage-discharge data for a specified sandbar site using the `bdrc` package.
#'
#' @param sitename A character string specifying the name of the sandbar site.
#' @return An object of class `gplm` containing the fitted model.
#' @examples
#' \dontrun{
#'   model <- fitGeneralizedPowerLawModel('0307R') # Assumes '0307R' is a valid site in SandbarSites
#' }
#' @export
fitGeneralizedPowerLawModel <- function(sitename){
  validSite(sitename) # Ensure site is valid
  index <- which(SandbarSites == sitename)
  df <- StageDischargeData[[index]]
  df <- as.data.frame(df)
  message('Using Package bdrc -- Bayesian Discharge Rating Curve')
  message(paste0("Using bdrc::gplm.fit to fit a generalized power law model for stage-discharge at: ", sitename, ' Sandbar'))
  message("This may take a few moments")
  gplm.fit <- bdrc::gplm(Q ~ W, data = df, parallel = TRUE, num_cores = 2)
  message("Plotting Rating Curve")
  graphics::plot(gplm.fit)
  return(gplm.fit)
}

#' Find Site Elevation Range
#'
#' Determines the minimum and maximum stage (elevation) recorded at a specified sandbar site.
#'
#' @param sitename A character string specifying the name of the sandbar site.
#' @return A numeric vector with two elements: the minimum and maximum elevation.
#' @examples
#' \dontrun{
#'   elevation_range <- findSiteElevation('2023R') # Assumes '2023R' is a valid site in SandbarSites
#' }
#' @export
findSiteElevation <- function(sitename){
  validSite(sitename) # Ensure site is valid
  index <- which(SandbarSites == sitename)
  df <- StageDischargeData[[index]]
  df <- as.data.frame(df)
  min_elevation <- round(min(df$W), 3)
  max_elevation <- round(max(df$W), 3)
  message(paste0("Minimum SD Elevation for site:", sitename, " = ", min_elevation))
  message(paste0("Maximum SD Elevation for site:", sitename, " = ", max_elevation))
  elevation_range <- c(min_elevation, max_elevation)
  return(elevation_range)
}

#' Generate Equally Spaced Stage-Discharge Grid
#'
#' Generates a grid of equally spaced stage values and their corresponding discharge predictions from a fitted model.
#'
#' @param sitename A character string specifying the name of the sandbar site.
#' @param ElevIncrement The elevation increment for the grid.
#' @return A data frame containing the elevation grid and corresponding discharge predictions.
#' @examples
#' \dontrun{
#'   grid <- GenerateEquallySpacedStageDischarge('2201R') # Assumes '2201R' is a valid site in SandbarSites
#' }
#' @export
GenerateEquallySpacedStageDischarge <- function(sitename, ElevIncrement = 0.001){
  validSite(sitename) # Ensure site is valid
  index <- which(SandbarSites == sitename)
  df <- StageDischargeData[[index]]
  df <- as.data.frame(df)
  min_elevation <- round(min(df$W), 3)
  max_elevation <- round(max(df$W), 3)
  model <- fitGeneralizedPowerLawModel(sitename)
  message('Generating equally spaced grid of elevations')
  message(paste0("from: ", min_elevation, " Meters to: ", max_elevation, " Meters"))
  message(paste0("increments of: ", ElevIncrement, " Meters"))
  h_grid <- seq(min_elevation, max_elevation, by = ElevIncrement)
  # Placeholder for prediction logic, using bdrc::predict or similar
  Grid <- data.frame(Elevation = h_grid) # This should be replaced with actual logic
  return(Grid)
}

#' Find Discharge for a Given Stage Elevation
#'
#' Determines the discharge at a specified stage elevation using a provided stage-discharge grid.
#'
#' @param Sitename The name of the site.
#' @param Grid A data frame or list containing the stage-discharge grid.
#' @param Elevation The elevation for which to find the corresponding discharge.
#' @return A data frame row or similar structure containing the discharge information at the specified elevation.
#' @examples
#' \dontrun{
#'   discharge_info <- find_Q_from_WSE('2201R', grid, 400.002) # Assumes '2201R' is a valid site and grid is defined
#' }
#' @export
find_Q_from_WSE <- function(Sitename, Grid, Elevation){
  validSite(Sitename) # Ensure site is valid
  # Placeholder for actual lookup logic
  dat <- Grid[1,] # This should be replaced with actual logic
  return(dat)
}
