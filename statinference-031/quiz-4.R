# Q1
baseline = c(140, 138, 150, 148, 135)
week2 = c(132, 135, 151, 146, 130)
t.test(baseline, week2, paired=TRUE, var.equal=FALSE)

# Q2
n = 9
mu = 1100
sd = 30
mu + (sd/sqrt(n)) * c(-1, 1) * qt(0.975, df=n-1)

# Q3
1 - pbinom(1, size=4, prob=0.5, lower.tail=FALSE)

# Q4
lambda.0 = 0.01       # 0-hypothesis: lambfa == 0.01, alternative: lambda < 0.01
lambda = 10 / 1787    # observed
s = 0
for (i in 0:9) {
  s = s + ppois(i, 17.87, lower.tail=TRUE)
}
s

# Q5
mu1 = -3
s1 = 1.5
mu2 = 1
s2 = 1.8
n1 = 9
n2 = 9
sp = sqrt(((n1-1)*s1^2 + (n2-1)*s2^2) / (n1+n2-2))
q = (mu2 - mu1) / sp
pnorm(q)

# Q7
n = 100
mu0 = 0
mua = 0.01
sd = 0.04
alpha = 0.05
z = qnorm(1 - alpha)
pnorm(mu0 + z * sd/sqrt(n), mean=mua, sd=sd/sqrt(n), lower.tail=FALSE)

# Q8
n = 140
pnorm(mu0 + z * sd/sqrt(n), mean=mua, sd=sd/sqrt(n), lower.tail=FALSE)
