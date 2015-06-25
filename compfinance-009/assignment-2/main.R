mean = 0.05
sd = 0.10

# Q1
(q1 = 1 - pnorm(0.10, mean, sd))

# Q2
(q2 = pnorm(-0.10, mean, sd))

# Q3
(q3 = pnorm(0.15, mean, sd) - pnorm(-0.05, mean, sd))

# Q4
(q4 = qnorm(0.01, mean, sd))

# Q5
(q5 = qnorm(0.05, mean, sd))

# Q6
(q6 = qnorm(0.95, mean, sd))

# Q7
(q7 = qnorm(0.99, mean, sd))

# Q8
t = seq(-0.25, 0.35, length=40)
x = dnorm(t, mean=0.05, sd=0.10)  # ms
y = dnorm(t, mean=0.025, sd=0.05) # sbux
plot(0, 0, xlim=c(-0.5, 0.5), ylim=c(0, 10), type="n")
cl = rainbow(2)
lines(t, x, col=cl[1], type='l') # red
lines(t, y, col=cl[2], type='l') # cyan

# Q9
w = 100000
(var1 = qnorm(0.01, mean=0.04, sd=0.09) * w)
(var5 = qnorm(0.05, mean=0.04, sd=0.09) * w)

# Q10
cc_to_simple = function(r) exp(r) - 1
w = 100000
(cc_var1 = cc_to_simple(qnorm(0.01, mean=0.04, sd=0.09)) * w)
(cc_var5 = cc_to_simple(qnorm(0.05, mean=0.04, sd=0.09)) * w)

pA0 = 38.23
pC0 = 41.11
pA1 = 41.29
pC1 = 41.74

# Q11
(srA = (pA1 - pA0) / pA0 * 100)
(srC = (pC1 - pC0) / pC0 * 100)

# Q12
(ccA = log(pA1 / pA0) * 100)
(ccC = log(pC1 / pC0) * 100)

# Q13
(div_yield_A = 0.10 / pA1 * 100)
(total_return_A = srA + div_yield_A)

# Q14
(ann_srA = (1 + srA / 100)^12 - 1) * 100
(ann_ccA = 12 * ccA)

# Q15 - too simple
(xA = 0.8)
(xC = 0.2)

# Q16
(port_return = xA * srA + xC * srC)
