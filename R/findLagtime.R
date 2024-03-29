#' Calculate Lag Time Based on River Mile
#'
#' This function estimates the lag time for water to travel from a given river mile to a specified point
#' based on the nearest upstream gage. It uses a linear model with coefficients (slope and intercept) provided
#' in a global `GageList` dataframe to compute the lag time in hours. The function allows for optional printing
#' of intermediate results, including the selected river mile, nearest gage name, distance to the gage in river
#' miles, and the calculated lag hours.
#'
#' @param rivermile Numeric; the river mile for which the lag time is to be calculated.
#' @param message Logical; if `TRUE`, prints the details of the calculation including the selected river mile,
#' nearest gage name, distance to the gage, and calculated lag hours. Defaults to `FALSE`.
#'
#' @return A list containing the following components:
#'   - `lagtime`: A `lubridate::duration` object representing the estimated lag time.
#'   - `nearest_gage`: The name of the nearest upstream gage used for the calculation.
#'   - `nearest_gage_index`: The index of the nearest gage within the `GageList` dataframe.
#'
#' @examples
#' \dontrun{
#'   out <- findLagtime(rivermile = 32.9, message = TRUE)
#'   print(out)
#' }
#'
#' @importFrom lubridate duration
#' @export
findLagtime <- function(rivermile, message = F) {
  i <- getNearestUpstreamGage(rivermile)
  gage_name <- unlist(GageList$GageNameStr[i])
  lag_slope <- unlist(GageList$LagSlope[i])
  lag_intercept <- unlist(GageList$LagIntercept[i])
  lag_hours <- lag_slope * rivermile + lag_intercept
  lagtime_hours <- lubridate::duration(lag_hours, units = 'hours')
  if (message == T) {
    distance <- rivermile - GageList$RiverMileNum[i]
    print(paste0("Selected river mile = ", rivermile,
                 " ;nearest gage = ", gage_name,
                 " ;distance in rivermiles = ", -distance,
                 ";lag hours = ", lag_hours))
  }
  out <- list('lagtime' = lagtime_hours, 'nearest_gage' = gage_name, 'nearest_gage_index' = i)
  return(out)
}


