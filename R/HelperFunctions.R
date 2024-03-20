#' Converts values from Cubic Meters per second to Cubic feet per second
#'
#' @param cms numeric value for cubic meters per second
#' @param messages Boolean TRUE or FALSE; default = FALSE, use messages = T to get more information
#'
#' @return numeric value for cubic feet per second
#' @export
#'
#' @examples
cms2cfs <- function(cms, messages = F){
  cfs <- cms* 35.31468492103444
  if (messages == TRUE){
    print(paste0("Converting ",cms," -- Cubic Meters per second to Cubic feet per second by multiplying 35.31468492103444" ))
    print(paste0("result =[", cfs,"] Cubic Feet Per Second"))
  }
  return(cfs)
}

#' Converts values from Cubic Feet per second to Cubic meters per second
#'
#' @param cfs numeric value for cubic feet per second
#' @param messages Boolean TRUE or FALSE; default = FALSE, use messages = T to get more information
#'
#' @return numeric value for cubic meters per second
#' @export
#'
#' @examples
cfs2cms <- function(cfs, messages = F){
  cms <- cfs/35.31468492103444
  if (messages == TRUE){
    print(paste0("Converting ",cfs," -- Cubic feet per second to Cubic meters per second by dividing by 35.31468492103444" ))
    print(paste0("result =[", cms,"] Cubic Meters Per Second"))
  }
  return(cms)
}
