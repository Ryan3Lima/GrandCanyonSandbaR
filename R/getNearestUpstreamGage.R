
#' function to find the nearest upstream gage in Grand Canyon to the desired rivermile
#'
#' @param riverMile numeric value between 0 and 283
#' @param messages Boolean T or F, default FALSE; TRUE shows messages, FALSE suppresses them
#'
#' @return int the index for the closest upstream gage in the dataframe (tibble) GageList
#' @export
#'
#' @examples
#' index <- getNearestUpstreamGage(23)
#' index <- getNearestUpstreamGage(103, TRUE)
getNearestUpstreamGage <- function(riverMile, messages = F) {
  # Load GageList dataset from the package
  GrandCanyonSandbaR::GageList

  # Ensure the input is within the valid range
  if (riverMile < 0 || riverMile > 283) {
    stop("River mile must be between 0 and 283.")
  }

  # Find the largest value in GageList that is less than or equal to riverMile
  # If riverMile is less than the first gage (i.e., no upstream gage exists), return a message or NA
  GageRiverMiles <- GageList$RiverMileNum

  # Identify the indices of GageList where the value is less than or equal to riverMile
  validIndices <- which(GageRiverMiles <= riverMile)
  nearestUpstreamGage <- max(GageRiverMiles[GageRiverMiles <= riverMile])
  nearestUpstreamGageIndex <- max(validIndices)
  if(messages){ # Max - You can remove the Boolean == TRUE, it will look a little cleaner and easier to maintain
  print(paste0("The Nearest Upstream Gage to riverMile:", riverMile, " is: ",GageList$GageNameStr[nearestUpstreamGageIndex], ' -- at riverMile: ',nearestUpstreamGage  ))
  print(paste0("Returning index for nearest upstream gage in data frame: GageList:", nearestUpstreamGageIndex))}
  return(nearestUpstreamGageIndex)
}

# Max - Nice function!
