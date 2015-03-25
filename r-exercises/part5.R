f1a = function(ts, m0=0, delta=0.7) {
  n = length(ts)
  m = rep(NA, n + 1)
  m[1] = m0
  for (i in 2:(n+1)) {
    m[i] = (1 - delta) * ts[i] + delta * m[i - 1]
  }
  ts(m[-1], start=start(ts), frequency=frequency(ts))
}

f1b = function(ts, m0=0, delta=0.7) {
  v = c(ts)
  n = length(v)
  m = rep(NA, n + 1)
  m[1] = m0
  for (i in 2:(n+1)) {
    m[i] = (1 - delta) * v[i] + delta * m[i - 1]
  }
  ts(m[-1], start=start(ts), frequency=frequency(ts))
}



f2a = function(n) {
  x = rnorm(n)
  mean = mean(x)
  y = if (mean >= 0) {
    rexp(n, mean)
  } else {
    -rexp(n, -mean)
  }
  k = sum(abs(y) > abs(x))
  list(xVec=x, yVec=y, count=k)
}

myList = lapply(rep(10, 1000), f2a)
allX = sapply(myList, FUN=function(item) { item$xVec })
allY = sapply(myList, FUN=function(item) { item$yVec })
myListCopy = lapply(myList, FUN=function(item) list(xVec=item$xVec, yVec=item$yVec))
moreThan2 = myList[which(unlist(lapply(myList, function(x){x[[3]]>2})))]


f3a = apply(myList, FUN=function(x) sum(x$xVec*(1:10)) / sum(x$yVec*(1:10)))
f3b = sapply(myList, function(x) x$xVec - x$yVec)
f3c = sum(apply(myList, function(x) sum(x$xVec[2] * (1:10000)))) /
      sum(sapply(myList, function(x){x$yVec[2]}) * sapply(myList, function(x){x$count}))
