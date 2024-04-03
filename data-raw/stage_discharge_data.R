library(dplyr)
library(magrittr)

convert2_bdrc_format <- function(df){
  df <- df %>%
    dplyr::mutate(Qcfs = Q)%>%
    dplyr::mutate(Q = Q*0.028316831998814504) %>%
    dplyr::mutate(W = Elevation) %>%
    dplyr::select(W,Q,Qcfs)
  return(df)
}



# 1
sitename <- '0034L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0034Lsd <- read.csv(filename, header = T)
RC0034Lsd <- convert2_bdrc_format(RC0034Lsd)

#2
sitename <- '0081L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0081Lsd <- read.csv(filename, header = T)
RC0081Lsd <- convert2_bdrc_format(RC0081Lsd)

#3
sitename <- '0089L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0089Lsd <- read.csv(filename, header = T)
RC0089Lsd <- convert2_bdrc_format(RC0089Lsd)

#4
sitename <- '0166L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0166Lsd <- read.csv(filename, header = T)
RC0166Lsd <- convert2_bdrc_format(RC0166Lsd)

#5
sitename <- '0220R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0220Rsd <- read.csv(filename, header = T)
RC0220Rsd <- convert2_bdrc_format(RC0220Rsd)

#6
sitename <- '0236L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0236Lsd <- read.csv(filename, header = T)
RC0236Lsd <- convert2_bdrc_format(RC0236Lsd)

#7
sitename <- '0307R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0307Rsd <- read.csv(filename, header = T)
RC0307Rsd <- convert2_bdrc_format(RC0307Rsd)

#8
sitename <- '0333L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0333Lsd <- read.csv(filename, header = T)
RC0333Lsd <- convert2_bdrc_format(RC0333Lsd)

#9
sitename <- '0414R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0414Rsd <- read.csv(filename, header = T)
RC0414Rsd <- convert2_bdrc_format(RC0414Rsd)

#10
sitename <- '0434L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0434Lsd <- read.csv(filename, header = T)
RC0434Lsd <- convert2_bdrc_format(RC0434Lsd)

#11
sitename <- '0445L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0445Lsd <- read.csv(filename, header = T)
RC0445Lsd<- convert2_bdrc_format(RC0445Lsd)

#12

sitename <- '0450L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0450Lsd <- read.csv(filename, header = T)
RC0450Lsd<- convert2_bdrc_format(RC0450Lsd)

#13
sitename <- '0476R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0476Rsd <- read.csv(filename, header = T)
RC0476Rsd <- convert2_bdrc_format(RC0476Rsd)

#14
sitename <- '0501R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0501Rsd <- read.csv(filename, header = T)
RC0501Rsd <- convert2_bdrc_format(RC0501Rsd)


#15
sitename <- '0515L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0515Lsd <- read.csv(filename, header = T)
RC0515Lsd <- convert2_bdrc_format(RC0515Lsd)

#16
sitename <- '0566R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0566Rsd <- read.csv(filename, header = T)
RC0566Rsd <- convert2_bdrc_format(RC0566Rsd)

#17
sitename <- '0629R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0629Rsd <- read.csv(filename, header = T)
RC0629Rsd <- convert2_bdrc_format(RC0629Rsd)

#18
sitename <- '0651R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0651Rsd <- read.csv(filename, header = T)
RC0651Rsd <- convert2_bdrc_format(RC0651Rsd)

#19
sitename <- '0688R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0688Rsd <- read.csv(filename, header = T)
RC0688Rsd <- convert2_bdrc_format(RC0688Rsd)

#20
sitename <- '0701R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0701Rsd <- read.csv(filename, header = T)
RC0701Rsd <- convert2_bdrc_format(RC0701Rsd)

#21
sitename <- '0817L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0817Lsd <- read.csv(filename, header = T)
RC0817Lsd <- convert2_bdrc_format(RC0817Lsd)

#22
sitename <- '0846R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0846Rsd <- read.csv(filename, header = T)
RC0846Rsd <- convert2_bdrc_format(RC0846Rsd)

#23
sitename <- '0876L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0876Lsd <- read.csv(filename, header = T)
RC0876Lsd <- convert2_bdrc_format(RC0876Lsd)

#24
sitename <- '0917R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0917Rsd <- read.csv(filename, header = T)
RC0917Rsd <- convert2_bdrc_format(RC0917Rsd)

#25
sitename <- '0938L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC0938Lsd <- read.csv(filename, header = T)
RC0938Lsd <- convert2_bdrc_format(RC0938Lsd)

#26
sitename <- '1044R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1044Rsd <- read.csv(filename, header = T)
RC1044Rsd <- convert2_bdrc_format(RC1044Rsd)

#27
sitename <- '1194R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1194Rsd <- read.csv(filename, header = T)
RC1194Rsd <- convert2_bdrc_format(RC1194Rsd)

#28
sitename <- '1227R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1227Rsd <- read.csv(filename, header = T)
RC1227Rsd <- convert2_bdrc_format(RC1227Rsd)

#29
sitename <- '1233L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1233Lsd <- read.csv(filename, header = T)
RC1233Lsd <- convert2_bdrc_format(RC1233Lsd)

#30
sitename <- '1377L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1377Lsd <- read.csv(filename, header = T)
RC1377Lsd <- convert2_bdrc_format(RC1377Lsd)

#31
sitename <- '1396R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1396Rsd <- read.csv(filename, header = T)
RC1396Rsd <- convert2_bdrc_format(RC1396Rsd)


#32
sitename <- '1459L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1459Lsd <- read.csv(filename, header = T)
RC1459Lsd <- convert2_bdrc_format(RC1459Lsd)


#33
sitename <- '1726L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1726Lsd <- read.csv(filename, header = T)
RC1726Lsd <- convert2_bdrc_format(RC1726Lsd)

#34
sitename <- '1833R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1833Rsd <- read.csv(filename, header = T)
RC1833Rsd <- convert2_bdrc_format(RC1833Rsd)

#35
sitename <- '1946L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC1946Lsd <- read.csv(filename, header = T)
RC1946Lsd <- convert2_bdrc_format(RC1946Lsd)

#36
sitename <- '2023R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC2023Rsd <- read.csv(filename, header = T)
RC2023Rsd <- convert2_bdrc_format(RC2023Rsd)

#37
sitename <- '2133L'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC2133Lsd <- read.csv(filename, header = T)
RC2133Lsd <- convert2_bdrc_format(RC2133Lsd)

#38
sitename <- '2201R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC2201Rsd <- read.csv(filename, header = T)
RC2201Rsd <- convert2_bdrc_format(RC2201Rsd)

#39
sitename <- '2255R'
filename <- paste0('data-raw/',sitename,"sd.csv")
df_name <- paste0('RC',sitename,'sd')
RC2255Rsd <- read.csv(filename, header = T)
RC2255Rsd <- convert2_bdrc_format(RC2255Rsd)


stage_discharge_data = list(RC0034Lsd,RC0081Lsd,RC0089Lsd,RC0166Lsd,RC0220Rsd,RC0236Lsd,RC0307Rsd,RC0333Lsd,
                            RC0414Rsd,RC0434Lsd,RC0445Lsd,RC0450Lsd,RC0476Rsd,RC0501Rsd,RC0515Lsd,RC0566Rsd,RC0629Rsd,
                            RC0651Rsd,RC0688Rsd,RC0701Rsd,RC0817Lsd,RC0846Rsd,RC0876Lsd,RC0917Rsd,RC0938Lsd,
                            RC1044Rsd,RC1194Rsd,RC1227Rsd,RC1233Lsd,RC1377Lsd,RC1396Rsd,RC1459Lsd,RC1726Lsd,
                            RC1833Rsd,RC1946Lsd,RC2023Rsd,RC2133Lsd,RC2201Rsd,RC2255Rsd)


usethis::use_data(stage_discharge_data, overwrite = TRUE)

# must document dataset
