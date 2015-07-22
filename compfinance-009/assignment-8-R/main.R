library("PerformanceAnalytics")
library("zoo")
source("portfolio.R")

load("lab8.RData")

t_bill_rate <- 0.03

mu_hat_annual <- apply(returns_df,2,mean)*12   
sigma2_annual <- apply(returns_df,2,var)*12
sigma_annual <- sqrt(sigma2_annual)
cov_mat_annual <- cov(returns_df)*12 
cov_hat_annual <- cov(returns_df)[1,2]*12   
rho_hat_annual <- cor(returns_df)[1,2]

mu_boeing <- mu_hat_annual["rboeing"]
mu_msft <- mu_hat_annual["rmsft"]
sigma2_boeing <-  sigma2_annual["rboeing"]
sigma2_msft <- sigma2_annual["rmsft"]
sigma_boeing <- sigma_annual["rboeing"]
sigma_msft <- sigma_annual["rmsft"]
sigma_boeing_msft <- cov_hat_annual
rho_boeing_msft <- rho_hat_annual

# Q1-Q2
(sharpe_ratio_boeing <- (mu_boeing - t_bill_rate) / sigma_boeing)
(sharpe_ratio_msft <- (mu_msft - t_bill_rate) / sigma_msft)

# Q3
global_min_var_portfolio <- globalMin.portfolio(er=mu_hat_annual, cov.mat=cov_mat_annual)
summary(global_min_var_portfolio, risk.free=0.03)

# Q4-Q6
tangency_portfolio <- tangency.portfolio(er=mu_hat_annual,
                                         cov.mat=cov_mat_annual,
                                         risk.free=0.03) 
summary(tangency_portfolio, risk.free=0.03)

# Q7-Q8
summary(global_min_var_portfolio, risk.free=0.03)
summary(tangency_portfolio, risk.free=0.03)

# Q9-Q10
tangency_weight <- sigma_msft / tangency_portfolio$sd
(mu_portfolio_efficient <- t_bill_rate + tangency_weight * (tangency_portfolio$er - t_bill_rate))
(t_bills_weight = 1 - tangency_weight)
