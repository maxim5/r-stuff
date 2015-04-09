library(XML)
library(data.table)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "1.csv", method="curl")
csv = read.csv("1.csv")
val = csv$VAL[complete.cases(csv$VAL)]
sum(val == 24)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile="1.xlsx", method="curl")
dat = read.xlsx("1.xlsx", rowIndex = 18:23, colIndex = 7:15, sheetIndex = 1)
sum(dat$Zip*dat$Ext,na.rm=T)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile = "1.xml", method="curl")
doc = xmlTreeParse("1.xml", useInternalNodes = TRUE)
root = xmlRoot(doc)
zipcodes = xpathSApply(root, "//zipcode", xmlValue)
sum(zipcodes == 21231)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "2.csv", method="curl")
DT = fread("2.csv")
