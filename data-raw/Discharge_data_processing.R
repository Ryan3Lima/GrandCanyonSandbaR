#' script to update* and process gage data

# library(dplyr)
# library(magrittr)
# library(tibble)
#
# # read gage data for gages
#
# #LeesFerry_Qdata_raw <- as_tibble(read_tsv("~/GrandCanyonSandbaR/data-raw/gcmrc20240306120450.tsv"))
# #ThirtyMile_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306120852.tsv"))
# #LCR_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306121200.tsv"))
# #Phantom_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306121809.tsv"))
# #National_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306122225.tsv"))
# #Diamond_Qdata_raw <-as_tibble(read_tsv("C:/Users/rylim/Documents/GitHub/GrandCanyonSandbaR/data-raw/gcmrc20240306122518.tsv"))
#
# LeesFerry_Qdata_raw <- tibble::as_tibble(read_tsv('data-raw/gcmrc20240306120450.tsv'))
# LeesFerryQ <- LeesFerry_Qdata_raw %>%
#   dplyr::mutate(dateTime = base::as.POSIXct(`time (MST)`, tz = "MST"))%>%
#   dplyr::mutate(Discharge_cfs = `Discharge(cfs)-09380000`)%>%
#   dplyr::mutate(Discharge_cms = cfs2cms(`Discharge(cfs)-09380000`)) %>%
#   dplyr::select(dateTime,Discharge_cfs,Discharge_cms)
#
# LeesFerryQ






