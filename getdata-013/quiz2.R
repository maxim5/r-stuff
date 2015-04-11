library(sqldf)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile="3.csv", method="curl")
acs = read.csv("3.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")

connection = url("http://biostat.jhsph.edu/~jleek/contact.html")
html = readLines(connection)
lines = html[c(10, 20, 30, 100)]
nchar(lines)

# http://stackoverflow.com/questions/14383710/read-fixed-width-text-file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile = "1.for", method="curl")
t = read.fwf(file="1.for", skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(t[,4])
