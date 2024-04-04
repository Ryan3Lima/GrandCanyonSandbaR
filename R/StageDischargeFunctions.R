#' @importFrom dplyr %>%
#' @importFrom bdrc gplm
#' @importFrom graphics plot
#' @importFrom stats setNames
NULL

#' Validate Site Name
#'
#' Checks if the provided site name is valid by verifying its presence in the `SandbarSites` dataset.
#'
#' @param sitename A character string of the site name to validate.
#' @return None; this function stops execution with an error message if the site name is invalid.
#' @examples
#'
#'validSite("0034L") # Assumes "0034L" is a valid site in SandbarSites
#'
#' @export
validSite <- function(sitename){
  if(!sitename %in% SandbarSites) {
    stop("Invalid sitename")
  }
  printColored("Valid sitename",'green')
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
  printColored('Using Package bdrc -- Bayesian Discharge Rating Curve', 'blue')
  m <- paste0("Using bdrc::gplm.fit to fit a generalized power law model for stage-discharge at: ", sitename, ' Sandbar')
  printColored(m,'blue')
  printColored("This may take a few moments",'blue')
  gplm.fit <- bdrc::gplm(Q ~ W, data = df, parallel = TRUE, num_cores = 2)
  printColored("Plotting Rating Curve",'green')
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
#' elevation_range <- findSiteElevation('2023R')
#'
#' @export
findSiteElevation <- function(sitename){
  validSite(sitename) # Ensure site is valid
  index <- which(SandbarSites == sitename)
  df <- StageDischargeData[[index]]
  df <- as.data.frame(df)
  min_elevation <- round(min(df$W), 3)
  max_elevation <- round(max(df$W), 3)
  m1<-paste0("Minimum SD Elevation for site:", sitename, " = ", min_elevation)
  m2 <-paste0("Maximum SD Elevation for site:", sitename, " = ", max_elevation)
  printColored(m1,'blue')
  printColored(m2,'blue')
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
#'   grid <- GenerateEquallySpacedStageDischarge('2201R')
#' }
#' @export
GenerateEquallySpacedStageDischarge <- function(sitename, ElevIncrement = 0.001){
  validSite(sitename) # Ensure site is valid
  index <- which(SandbarSites == sitename)
  df <- StageDischargeData[[index]]
  df <- as.data.frame(df)
  min_elevation <- round(min(df$W), 3)
  max_elevation <- round(max(df$W), 4)
  model <- fitGeneralizedPowerLawModel(sitename)
  printColored('Generating equally spaced grid of elevations','green')
  m<-paste0("from: ", min_elevation, " Meters to: ", max_elevation, " Meters")
  printColored(m,'blue')
  m1<-paste0("increments of: ", ElevIncrement, " Meters")
  printColored(m1,'blue')
  h_grid <- seq(min_elevation, max_elevation, by = ElevIncrement)
  rating_curve_h_grid <- predict(model,newdata=h_grid)
  Grid <- rating_curve_h_grid %>%
    dplyr::mutate(Elevation = h)%>%
    dplyr::mutate(CMS_lower = lower)%>%
    dplyr::mutate(CMS_median = median)%>%
    dplyr::mutate(CMS_upper = upper)%>%
    dplyr::mutate(CFS_lower = lower*35.31468492103444)%>%
    dplyr::mutate(CFS_median = median*35.31468492103444)%>%
    dplyr::mutate(CFS_upper = upper*35.31468492103444)%>%
    dplyr::select(Elevation,CMS_lower,CMS_median,CMS_upper,CFS_lower,CFS_median,CFS_upper)
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
#'   discharge_info <- find_Q_from_WSE('2201R', grid, 400.002)
#' }
#' @export
find_Q_from_WSE <- function(Sitename, Grid, Elevation){
  # check if sitename valid
  validSite(Sitename)
  # check if Elevation is Valid
  Elevation_range <- findSiteElevation(Sitename)
  if(Elevation >= Elevation_range[1] & Elevation <= Elevation_range[2]) {
    print(paste0("valid elevation for site:", Sitename))
  }else{
    stop(paste0(Elevation, " Not in Range: ", Elevation_range[1], '-to:', Elevation_range[2]))
  }
  G_i <- which.min(abs(Grid$Elevation - Elevation))
  print(G_i)
  dat <- Grid[G_i,]
  return(dat)

}


