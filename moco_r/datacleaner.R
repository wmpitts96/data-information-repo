#### Load packages
library(tidyverse)
library(readxl)
library(lubridate)

#### Load data

#moco <- read_xlsx("moco_dirty.xlsx")
#glimpse(moco)

#### Fix weird time

#moco_clean <- moco %>%
#  mutate(xh = hour(ViolationTime),
#         xm = minute(ViolationTime),
#         time_x = paste0(xh,":", xm),
#         time_x = hm(time_x))

#view(moco)

moco <- read_xlsx("moco_cleaner.xlsx")

moco_cleaned <- moco %>%
  mutate(xh = hour(ViolationTime),
         xm = minute(ViolationTime),
         vtime = 
           fast_strptime("xh:xm", hm))
view(moco_cleaned)