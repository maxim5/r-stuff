library(dplyr)
library(magrittr)

library(ggplot2)
library(scales)
library(zoo)

data = read.csv("table.csv") %>% tbl_df()
clean = data %>%
        mutate(Date=as.Date(Date), Price=Adj.Close) %>%
        arrange(Date) %>%
        mutate(NormPrice=Price / Price[1]) %>%
        subset(select=c("Date", "Price", "NormPrice"))

prices = clean$Price
p0 = prices[1]
p1 = prices[length(prices)]

draw_date_chart = function(data, value) {
  ggplot(data, aes_string(x="Date", y=value, group=1)) +
    geom_line() +
    scale_x_date(labels=date_format("%m %y"), breaks=date_breaks("year"))
}

# Q1
draw_date_chart(clean, "NormPrice")

# Q2
sr = (p1 - p0) / p0
(investment = 1000 * (1 + sr))

# Q3
(ccr = log(p1 / p0) / 15) * 100

# Q4
draw_date_chart(mutate(clean, LogPrice=log(NormPrice)), "LogPrice")

# Q5
returns = rollapply(prices, 2, FUN=function(z) { (z[2] - z[1]) / z[1] })
draw_date_chart(mutate(clean, Return=c(0, returns)), "Return")

# Q6
ann_returns = rollapply(prices, 13, FUN=function(z) { (z[13] - z[1]) / z[1] })
draw_date_chart(mutate(clean, AnnualReturn=c(rep(0, 12), ann_returns)), "AnnualReturn")

# Q7
cc_returns = rollapply(prices, 2, FUN=function(z) { log(z[2] / z[1]) })
draw_date_chart(mutate(clean, CCReturn=c(0, cc_returns)), "CCReturn")

# Q6
cc_ann_returns = rollapply(prices, 13, FUN=function(z) { log(z[13] / z[1]) })
draw_date_chart(mutate(clean, CCAnnualReturn=c(rep(0, 12), cc_ann_returns)), "CCAnnualReturn")
