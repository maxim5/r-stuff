library(dplyr)
library(magrittr)
library(zoo)

Sys.setlocale("LC_TIME", "en_US.UTF-8")

data = read.table("data.csv") %>% tbl_df()
clean = data %>%
        mutate(Date=as.Date(as.yearmon(paste(V1, V2), format="%B, %Y"))) %>%
        mutate(Price=as.numeric(substring(V3, 2))) %>%
        subset(select=c("Date", "Price"))
prices = clean$Price

# Q1. Simple return
simple_return = function(p0, p1) {
  (p1 - p0) / p0
}
(q1 = simple_return(prices[1], prices[2])) * 100

# Q2. Investment
(q2 = (1 + q1) * 10000)

# Q3. CC return
cc_return = function(p0, p1) {
  log(p1 / p0)
}
(q3 = cc_return(prices[1], prices[2])) * 100

# Q4. Simple annual return
(q4 = (1 + q1)^12 - 1) * 100

# Q5. CC annual return
(q5 = q3 * 12) * 100

# Q6. Simple annual return
(q6 = simple_return(prices[1], prices[13])) * 100

# Q7. Investment
(q7 = (1 + q6) * 10000)

# Q8. CC return
(q8 = cc_return(prices[1], prices[13])) * 100
