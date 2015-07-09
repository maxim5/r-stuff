simple_return = function(p0, p1) {
  (p1 - p0) / p0
}
cc_return = function(p0, p1) {
  log(p1 / p0)
}

# end of September, 2010
p_VFINX_0 = 105.06
p_VFINX_1 = 109.04

# end of October, 2010
p_VEIEX_0 = 28.64
p_VEIEX_1 = 29.49

(q1 = simple_return(p_VFINX_0, p_VFINX_1)) * 100
(q2 = simple_return(p_VEIEX_0, p_VEIEX_1)) * 100
(q3 = cc_return(p_VFINX_0, p_VFINX_1)) * 100
(q4 = cc_return(p_VEIEX_0, p_VEIEX_1)) * 100
(q5 = (1 + q1)^12 - 1) * 100
(q6 = (1 + q2)^12 - 1) * 100
(q7 = q3 * 12) * 100
(q8 = q4 * 12) * 100

w0 = 10000
(q9 = cumprod(rep(1 + q1, 12)) * w0)
(q10 = cumprod(rep(1 + q2, 12)) * w0)

port0 = 0.2 * p_VFINX_0 + 0.8 * p_VEIEX_0
port1 = 0.2 * p_VFINX_1 + 0.8 * p_VEIEX_1

(q13 = 0.2 * q1 + 0.8 * q2) * 100
(q14 = log(1 + q13)) * 100
# Not clear why not?
# simple_return(port0, port1) * 100
# cc_return(port0, port1) * 100

############################

cc_to_simple = function(r) exp(r) - 1

w0 = 100000
(q17 = cc_to_simple(qnorm(0.05, mean=0.001, sd=0.05)) * w0)
(q18 = cc_to_simple(qnorm(0.05, mean=0.01, sd=0.09)) * w0)
(q19 = cc_to_simple(qnorm(0.05, mean=0.001 * 12, sd=0.05 * sqrt(12))) * w0)
(q20 = cc_to_simple(qnorm(0.05, mean=0.01 * 12, sd=0.09 * sqrt(12))) * w0)

sigma_eps = 1.5
a = 3
phi = 0.45
(q27 = a / (1 - phi))
(q28 = sigma_eps^2 / (1 - phi^2))
(q29 = phi * q28)
(q30 = phi^1)
