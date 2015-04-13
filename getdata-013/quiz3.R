library(dplyr)
library(jpeg)
library(stringr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "q3-1.csv", method="curl")
csv = read.csv("q3-1.csv")
head(csv)
which(csv$ACR == 3 & csv$AGS == 6)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="jeff.jpg", method="curl")
img = readJPEG("jeff.jpg", native=TRUE)
v = as.vector(img)
quantile(v, probs = c(0.3, 0.8))

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "q3-2.csv", method="curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "q3-3.csv", method="curl")
gdp = read.csv("q3-2.csv", skip=4, stringsAsFactors=FALSE, nrow=215)
stats = read.csv("q3-3.csv", stringsAsFactors=FALSE)

names(gdp)[1] = "CountryCode"
length(intersect(gdp$CountryCode, stats$CountryCode))
gdp = gdp %>% mutate(size = as.numeric(gsub(",","", str_trim(gdp$X.4)))) %>% 
      filter(!is.na(size))
arrange(gdp, size)[13,]

merged = merge(stats, gdp, "CountryCode")
merged = mutate(merged, gdp_rank = rank(-size, ties.method = "first"))
merged = arrange(merged, gdp_rank)
#head(select(merged, CountryCode, size, gdp_rank, Income.Group), n=50)
mean(filter(merged, Income.Group == "High income: OECD")$gdp_rank)
mean(filter(merged, Income.Group == "High income: nonOECD")$gdp_rank)

quantile(merged$size)
merged %>% filter(gdp_rank <= 38, Income.Group == "Lower middle income") %>% select(CountryCode, size, gdp_rank, Income.Group)
