#' Find Median Predicted Discharge from Water Surface Elevation
#'
#' This function calculates the median predicted discharge for a given water surface elevation
#' at a specified site using precomputed stage-discharge relationships. It checks for valid site name,
#' elevation range, and unit of discharge before proceeding.
#'
#' @param Sitename A string representing the site name; must be a valid site within the preloaded `SandbarSites` data.
#' @param Elevation A numeric value representing the water surface elevation in meters; must be within the valid range for the site.
#' @param Unit The unit of discharge: either "CFS" (Cubic Feet per Second) or "CMS" (Cubic Meters per Second).
#'             Default is "CFS".
#'
#' @return A list containing discharge information at the given elevation, including lower, median, and upper estimates in the specified unit.
#'         Access specific discharge information using the keys from the list like `ReturnedList$CFS_median` or `ReturnedList$CMS_median`.
#'
#' @examples
#' out <- findQfromWSE("0081L", 915.345)
#'
#' @details The function first verifies the site name and elevation against pre-stored values.
#' If the site name or elevation is invalid, it throws an error.
#' It also checks if the provided unit is valid and throws an error if not.
#' After validation, it retrieves the closest grid row to the specified elevation from a precomputed dataframe,
#' converts the relevant row to a list, and returns the discharge values for the median prediction.
#'
#' @export
findQfromWSE <- function(Sitename, Elevation, Unit = 'CFS'){
  # check if sitename valid
  #validSite(Sitename)
  # check if valid site elevation and site name
  E_range <- findSiteElevation(Sitename)
  min_E <- E_range[1]
  max_E <- E_range[2]
  if(Elevation >= min_E & Elevation <= max_E){
    printColored("Valid Elevation",'green')
  } else {
    stop(paste0("Invalid Elevation, must be within range:",min_E," to ",max_E ))
  }
  # Check if valid Qunit
  if(Unit %in% c("CFS", "CMS")) {
    printColored("Valid Qunit")}else{
      stop("Invalid Qunit. Choose either 'CFS' or 'CMS'")
    }
  Grid_site <- StageDischargeGrids[[Sitename]]
  Grid_index <- which.min(abs(Grid_site$Elevation - Elevation))
  Grid_row <- Grid_site[Grid_index,]
  row_as_list <- as.list(Grid_row[1, ])
  if (Unit == 'CFS') {
    mes1 <- paste0('The median predicted discharge at the selected elevation is: ',row_as_list$CFS_median,' CFS. Access using ReturnedList$CFS_median')
    range = row_as_list$CFS_upper - row_as_list$CFS_lower
    mes11 <- paste0("The uncertainty in this discharge measurment is: (+/-) ",range/2, " CFS ")
    printColored(mes1, 'blue')
    printColored(mes11, 'blue')
  } else if (Unit == 'CMS') {
    mes2 <- paste0('The median predicted discharge at the selected elevation is: ',row_as_list$CMS_median,' CMS. Access using ReturnedList$CMS_median')
    range = row_as_list$CMS_upper - row_as_list$CMS_lower
    mes22 <- paste0("The uncertainty in this discharge measurment is: (+/-)",range/2, " CMS ")
    printColored(mes2, 'blue')
    printColored(mes22, 'blue')
  } else {
    stop('Something went terribly wrong, probably the wrong unit')
  }
  return(row_as_list)
}


