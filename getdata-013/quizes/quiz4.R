library(dplyr)
library(stringr)
library(quantmod)

Sys.setlocale("LC_TIME", "en_US.UTF-8")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "q4-1.csv", method="curl")
csv = read.csv("q4-1.csv")
strsplit(names(csv), "wgtp")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "q4-2.csv", method="curl")
gdp = read.csv("q4-2.csv", skip=4, stringsAsFactors=FALSE)
gdp = gdp %>% mutate(size = as.numeric(gsub(",","", str_trim(gdp$X.4)))) %>% 
      filter(!is.na(size))
mean(gdp$size[1:190])

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "q4-3.csv", method="curl")
stats = read.csv("q4-3.csv", stringsAsFactors=FALSE)

names(gdp)[1] = "CountryCode"
merged = merge(stats, gdp, "CountryCode")
# ???

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
sum(format(sampleTimes, "%Y") == "2012")
sum(format(sampleTimes, "%Y") == "2012" & format(sampleTimes, "%a") == "Mon")
