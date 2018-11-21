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
library("broom")

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
#' tidy example
wx.dat <- meteo_pull_monitors(seug.stations$id, # pull data from GHCND ftp site
                              var = c("prcp", "tmax", "tmin"), 
                              date_max = today()) %>%
  left_join(seug.stations) %>% # merge station names
  mutate(name = factor(name, # format station names to factors
                       levels = c("ARCH", "ISKY", "MAZE", "NEED", "HOVE", 
                                  "NABR", "MOAB"))) %>%
  gather(var, value, prcp:tmin) %>% # convert from short-wide to long-skinny data
  select(id, name, date, var, value) %>% # rearrange dataframe
  arrange(id, date, var) # sort

#' non-tidy example
wx.dat <- meteo_pull_monitors(seug.stations$id, # pull data from GHCND ftp site
                              var = c("prcp", "tmax", "tmin"), 
                              date_max = today())
wx.dat <- left_join(wx.dat, seug.stations)# merge station names
wx.data <- mutate(wx.data, name = factor(name, # format station names to factors
                                         levels = c("ARCH", "ISKY", "MAZE", 
                                                    "NEED", "HOVE", "NABR", 
                                                    "MOAB"))) 
# etc., etc.,...

#' group_by example
Wx.mean <- wx.dat %>%
  mutate(Year = year(date)) %>%
  group_by(Year, name, var) %>% # Groupoing by year, name, var
  summarise(Mean = mean(value, na.rm = T))

#' Create simple metadata for weather stations 
seug.stations <- wx.dat %>%
  group_by(id, name) %>%
  summarise(startDate = min(date, na.rm = T), 
            endDate = max(date, na.rm = T)) %>%
  arrange(name)
knitr::kable(seug.stations) # using knitr's kable command to nicely print table

#+ Keys ----
#' Build keys
wx.dat.key <- wx.dat %>%
  mutate(key = paste(as.character(date), id, var, sep = ".")) %>%
  select(key, value)

#' Decipher keys
wx.dat.key %>%
  separate(col = key, 
           into = c("date", "id", "var"), 
           sep = "\\.",
           convert = T) %>%
  mutate(date = ymd(date))

#+ purr example ----
#' Anova
Wx.mean %>%
  filter(var == "tmax") %>%
  group_by(name) %>%
  do(., glance(aov(Mean ~ Year, data = .)))

#' classic anova summary output
aov(Mean ~ Year, data = Wx.mean)


#+ Plyr example from Cody ----
library("plyr")
library("ggplot2")
# split-apply-combine approach
# split or "subset" data into distinct groups
# apply a function to the subset
# recombine the subsetted data into one object
# what is the mean weight of chickens on different diets over time>?
ChickWeight  # look at data
newchics <- ddply(ChickWeight, ~Diet+Time, summarize, 
      mean_weight = mean(weight), # new column
      stdev_weight = sd(weight)) # new column

ggplot(newchics, aes(x = Time, y = mean_weight, group = Diet, color = Diet)) + 
  geom_line() + ggtitle("Chicken Weight Through Time: 4 different diets")

#' The same data wrangling using dplyr
library(tidyverse)
ChickWeight %>%
  group_by(Diet, Time) %>%
  summarise(mean_weight = mean(weight), 
            sd_weight = sd(weight)) -> chicks2
ggplot(chicks2, aes(x = Time, y = mean_weight, group = Diet, color = Diet)) +
  geom_line() +
  ggtitle("Chicken weight through time: 4 diest") +
  theme_bw()

#+ Session info ----
today()
sessionInfo()