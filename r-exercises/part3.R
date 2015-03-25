f1 = function(x) {
  x ^ (1:length(x))
}

f2 = function(x) {
  x ^ (1:length(x)) / (1:length(x))
}

f3 = function(x, n) {
  sum(rep(x, n+1) ^ (0:n) / c(1, 1:n))
}

f = function(x) {
  l = length(x)
  (x[-c(l-1,l)] + x[-c(1,l)] + x[-c(1,2)]) / 3
}

f = function(x) {
  ifelse(x < 0, x * x  + 2 * x + 3, ifelse(x < 2, x + 3, x * x + 4 * x - 7))
}

doub = function(m) {
  m[m %% 2 == 1] = 2 * m[m %% 2 == 1]
  m
}

pretty = function(n, k) {
  m = matrix(rep(0, n^n), n, n)
  m[abs(row(m)-col(m)) == 1] = 1
  m[row(m) == col(m)] = k
  m
}

quadrant = function(alpha) {
  (alpha %% 360) %/% 90 + 1
}

weekday = function(day, month, year) {
  k = day
  m = (month - 2) %% 12 + 1
  c = year %/% 100
  y = year %% 100
  t = (floor(2.6 * m - 0.2) + k + y + floor(y/4) + floor(c/4) - 2 * c) %% 7
  c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")[1 + t]
}

weekday0 <- function(day, month, year)
{
  month <- month - 2
  if(month <= 0) {
    month <- month + 12
    year <- year - 1
  }
  cc <- year %/% 100
  year <- year %% 100
  tmp <- floor(2.6*month - 0.2) + day + year + year %/% 4 + cc %/% 4 - 2 * cc
  c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")[1+tmp%%7]
}

testLoop = function(n) {
  x = rep(0, n-1)
  x[1] = 1
  x[2] = 2
  for (i in 3:(n-1)) {
    x[i] = x[i-1] + 2/x[i-1]
  }
  x
}

testLoop2 = function(y) {
  sum(exp(seq(along=y)))
}

quadmap = function(start, rho, niter) {
  n = niter
  x = rep(NA, n)
  x[1] = start
  for (i in 2:n) {
    x[i] = rho * x[i-1] * (1 - x[i-1])
  }
  x
}

quad2 = function(start, rho) {
  x = start
  i = 1
  while (TRUE) {
    y = rho * x * (1 - x)
    if (abs(x - y) < 0.02) {
      break;
    }
    i = i + 1
    x = y
  }
  i;
}

autocorr = function(x, k) {
  xc = x - mean(x)
  se = sum(xc^2)
  n = length(x)
  sapply(1:k, function(j) {
    sum(xc[(j+1):n] * xc[1:(n-j)]) / se
  })
}

autocorr2 = function(x) {
  xc = x - mean(x)
  se = sum(xc ^ 2)
  n = length(x)
  r1 = sum(xc[2:n] * xc[1:(n-1)]) / se
  r2 = sum(xc[3:n] * xc[1:(n-2)]) / se
  c(r1, r2)
}

tmpAcf <- function(xVec)
{
  xc <- xVec - mean(xVec)
  denom <- sum(xc^2)
  n <- length(xVec)
  r1 <- sum( xc[2:n] * xc[1:(n-1)] )/denom
  r2 <- sum( xc[3:n] * xc[1:(n-2)] )/denom
  list(r1 = r1, r2 = r2)
}
