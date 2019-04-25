#### Load packages
library(tidyverse)
library(readxl)
library(lubridate)

moco <- read_csv("moco_cleaner.csv")

moco_cleaned <- moco %>%
  mutate(x = strptime(MERGED, format="%d/%m/%Y %H:%M:%S")) %>% 
  format(x, "%H:%M:%S")