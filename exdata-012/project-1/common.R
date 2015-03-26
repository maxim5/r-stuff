library(dplyr)
library(magrittr)

# common settings
Sys.setlocale("LC_TIME", "en_US.UTF-8")
par(mar=c(5, 4, 4, 4), ps=12)

# read the data, the magic numbers skip=65000, nrows=5000 obtained using bash to speed it all up.
file = "household_power_consumption.txt"
just_header = file %>% 
              read.csv(sep=";", na.strings="?", nrows=1)
raw = file %>%
      read.csv(sep=";", na.strings="?", skip=65000, nrows=5000) %>%
      tbl_df()
colnames(raw) = colnames(just_header)
date_factors = raw$Date %>%
               levels() %in% c("1/2/2007", "2/2/2007") %>%
               which()
filtered = raw %>% filter(as.numeric(Date) %in% date_factors)
data = filtered %>%
       mutate(TimeStamp=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
