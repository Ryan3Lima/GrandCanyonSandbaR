# Data Raw Directory

## Overview
'''
This directory contains scripts used to generate the `StageDischargeGrids` dataset, which models the stage discharge relationship using a Bayesian power law model.

## Usage
To update the dataset with new data:
  1. Update the stage discharge table for the required site, e.g., `0034Lsd.csv`.
2. Run `StageDischargeData.R` to remake the `StageDischargeData` dataframe.
3. Run `StageDischargeGrids.R` (this script) to recreate the grids.

## Dependencies
- tidyverse
- bdrc

Make sure these packages are installed and up-to-date before running the scripts.
'''
library(tidyverse)
library(bdrc)




printColored_int <- function(text, color = "green") {
  colors <- list(
    green = "\033[32m",
    blue = "\033[34m",
    red = "\033[31m",
    reset = "\033[0m"
  )

  color_code <- colors[[color]]
  reset_code <- colors$reset

  message(paste0(color_code, text, reset_code))
}


GenerateEquallySpacedStageDischarge_internal <- function(sitename, ElevIncrement = 0.001){
  validSite(sitename) # Ensure site is valid
  index <- which(SandbarSites == sitename)
  df <- StageDischargeData[[index]]
  df <- as.data.frame(df)
  min_elevation <- round(min(df$W), 3)
  print(min_elevation)
  max_elevation <- round(max(df$W), 4)
  print(max_elevation)
  model <- fitGeneralizedPowerLawModel(sitename)
  printColored_int('Generating equally spaced grid of elevations','blue')
  statement1 <- paste0("from: ", min_elevation, " Meters to: ", max_elevation, " Meters")
  printColored_int(statement1,'blue')
  statement2 <-paste0("increments of: ", ElevIncrement, " Meters")
  printColored_int(statement2,'blue')
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


StageDischargeGrids <- list()
for (site in SandbarSites) {
  # Generate a dynamic name for the list element
  name <- site

  # Call your function and assign the result to the appropriate list element
  StageDischargeGrids[[name]] <- GenerateEquallySpacedStageDischarge_internal(site)
}
## test
#str(SandbarSites)
#SITE <- SandbarSites[39]
#SITE
#StageDischargeGrids[[SITE]]

usethis::use_data(StageDischargeGrids, overwrite = TRUE)


