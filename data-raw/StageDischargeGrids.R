library(tidyverse)
library(bdrc)


printColored <- function(text, color = "green") {
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
  printColored('Generating equally spaced grid of elevations','blue')
  statement1 <- paste0("from: ", min_elevation, " Meters to: ", max_elevation, " Meters")
  printColored(statement1,'blue')
  statement2 <-paste0("increments of: ", ElevIncrement, " Meters")
  printColored(statement2,'blue')
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


GenerateEquallySpacedStageDischarge_internal('030')

StageDischargeGrids <- list()
for (site in SandbarSites) {
  # Generate a dynamic name for the list element
  name <- paste0("RC", site, "grid")

  # Call your function and assign the result to the appropriate list element
  StageDischargeGrids[[name]] <- GenerateEquallySpacedStageDischarge_internal(site)
}

usethis::use_data(StageDischargeGrids, overwrite = TRUE)


