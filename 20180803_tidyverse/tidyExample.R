#' ---
#' title: "tidyverse Demo for Moab Use-R Group"
#' author: "Matt Van Scoyoc"
#' date: "3 August, 2018"
#' ---
#' 
#' Original date: 27 July, 2018  
#' Revision date:   
#'
#' Project: Moab Use-R Group  
#' Data files:  
#'   - downloaded from NCDC Global Historic Climate Network Daily (GHCND) ftp 
#'     site  
#' Notes:  
#'----------------------------------------------------------------------

#+ setup ----
# install.packages(c("rnoaa", "tidyverse", "lubridate", "knitr"))
library("rnoaa")
library("tidyverse")
library("lubridate")

#+ downloadData ----
#' Identify Co-op weather stations of interest
seug.stations <- data.frame(id = c("USC00420336", "USC00421163", "USC00421168", 
                                   "USC00423600", "USC00424100", "USC00425733", 
                                   "USC00426053"), 
                            name = factor(c("ARCH", "ISKY", "NEED", "MAZE", 
                                            "HOVE", "MOAB", "NABR"), 
                                          levels = c("ARCH", "ISKY", "MAZE", 
                                                     "NEED", "HOVE", "NABR", 
                                                     "MOAB")))

#' Download data from the Global Histoic Climate Network
wx.dat <- meteo_pull_monitors(seug.stations$id, 
                              var = c("prcp", "tmax", "tmin"), 
                              date_max = today()) %>%
  left_join(seug.stations) %>%
  mutate(name = factor(name, 
                       levels = c("ARCH", "ISKY", "MAZE", "NEED", "HOVE", 
                                  "NABR", "MOAB"))) %>%
  gather(var, value, prcp:tmin) %>%
  select(id, name, date, var, value) %>%
  arrange(id, date, var)

#' Create simple metadata for weather stations 
seug.stations <- wx.dat %>%
  group_by(id, name) %>%
  summarise(startDate = min(date, na.rm = T), 
            endDate = max(date, na.rm = T)) %>%
  arrange(name)
knitr::kable(seug.stations) 
