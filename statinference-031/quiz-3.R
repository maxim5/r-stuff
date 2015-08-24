mean = 1100
sd = 30
qt(0.95, df=9)
q1 = c(mean + qt(0.025, df=8) * sd/sqrt(9), mean + qt(0.975, df=8) * sd/sqrt(9))
q1

sd = 2.6
q2 = qt(0.975, df=8) * sd/sqrt(9)
q2

mu1 = 3
s1 = 0.6   # variance!
n1 = 10
mu2 = 5
s2 = 0.68  # variance!
n2 = 10
sp = sqrt(((n1-1)*s1 + (n2-1)*s2) / (n1+n2-2))
d = qt(0.975, df=n1+n2-2) * sp * (1/n1 + 1/n2)^0.5
q4 = mu1 - mu2 + c(-1, 1) * d
q4

mu1 = 4
s1 = 0.5
mu2 = 6
s2 = 2
n1 = 100
n2 = 100
sp = sqrt(((n1-1)*s1^2 + (n2-1)*s2^2) / (n1+n2-2))
#q5 = mu2 - mu1 + c(-1, 1) * qt(0.975, df=n1+n2-2) * sp * (1/n1 + 1/n2)^0.5
q5 = mu2 - mu1 + c(-1, 1) * qnorm(0.975) * sp * (1/n1 + 1/n2)^0.5
q5

n = 9
diff1 = -3
sd1 = 1.5
diff2 = 1
sd2 = 1.8
sp = sqrt(((n-1)*sd1^2 + (n-1)*sd2^2) / (n+n-2))
q6 = diff1 - diff2 + c(-1, 1) * qt(0.95, df=n+n-2) * sp * (1/n + 1/n)^0.5
q6
