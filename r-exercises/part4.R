f1a = function(x, y) {
  m = outer(x, y, ">")
  rowSums(m)
}

f1b = function(x, y) {
  sapply(x, function(a) {sum(y < a)})
}

f1b_2 = function(x, y) {
  # Their solution:
  # rowSums(sapply(y, function(a) {a < x}))
  colSums(sapply(x, function(a) {y < a}))
}

f1c = function(x, y) {
  rowSums(vapply(y, FUN=function(a) a < x, FUN.VALUE=seq(along=x)))
}

f1_all = function(x, y) {
  print(f1a(x, y))
  print(f1b(x, y))
  print(f1b_2(x, y))
  print(f1c(x, y))
  print("")
}
f1_check = function() {
  f1_all(1:5, 2:6)
  f1_all(c(2, 5, 6, 1, 7, 3), c(1, 9, 8, 7))
  f1_all(c(2, 5, 3, 1, 7, 3, 10), c(2, 9, 4, 7, 10))
  f1_all(0:2, c(4, 9, 8, 7))
  f1_all(c(4, 9, 8, 7), 0:2)
}


f2a = function(m) {
  m[, !apply(is.na(m), 2, any), drop=FALSE]
}

f2b = function(m) {
  m[!apply(is.na(m), 1, any), !apply(is.na(m), 2, any), drop=FALSE]
}


empCopula = function(u, v, x, y) {
  n = length(x)
  r = rank(x, ties.method="first") / (n + 1)
  s = rank(y, ties.method="first") / (n + 1)
  
  # Can be simplier:
  # sum((r <= u) & (s <= v)) / n
  sum(sapply(1:n, function(i) r[i] <= u & s[i] <= v)) / n
}

empCopula2 = function(u, v, x, y) {
  n = length(x)
  r = rank(x, ties.method="first") / (n + 1)
  s = rank(y, ties.method="first") / (n + 1)
  values = mapply(FUN=function(u_, v_) sum(r <= u_ & s <= v_), u, v)
  cbind(u=u, v=v, copula=values / n)
}


f4a = function(n) {
  result = 0
  for (r in 1:n) {
    for (s in 1:r) {
      result = result + (s^2) / (10 + 4 * r^3)
    }
  }
  result
}

f4b = function(n) {
  m = matrix(0, n, n)
  sum((col(m)^2) / (10 + 4 * row(m)^3) * (row(m) >= col(m)))
}

f4c = function(n) {
  sum(outer(1:n, 1:n, FUN = function(r, s) (s^2) / (10 + 4 * r^3) * (r >= s)))
}

f4d = function(n) {
  # inner = function(r) {
  #   sum(sapply(1:r, function(s) (s^2) / (10 + 4 * r^3)))
  # }
  inner = function(r) sum(((1:r)^2) / (10+4*r^3))
  sum(sapply(1:n, inner))
}

f4e = function(n) {
  inner = function(r, s) {
    (s <= r) * (s^2) / (10 + 4 * r^3)
  }
  sum(mapply(rep(1:n, times=rep(n, n)), 1:n, FUN=inner))
}

f4_all = function(n) {
  print(f4a(n))
  print(f4b(n))
  print(f4c(n))
  print(f4d(n))
  print(f4e(n))
  print("")
}
f4_time = function(n) {
  print(system.time(f4a(n)))
  print(system.time(f4b(n)))
  print(system.time(f4c(n)))
  print(system.time(f4d(n)))
  print(system.time(f4e(n)))
  print("")
}
f4_check = function() {
  f4_all(1)
  f4_all(2)
  f4_all(3)
  f4_all(4)
}


f5a = function(n, aRate, sRate) {
  a = rexp(n, aRate)
  s = rexp(n, sRate)
  w = 0
  for (i in 1:n) {
    w = max(0, w + s[i] - a[i])
  }
  w
}

f5b = function(nReps, n, aRate, sRate) {
  replicate(nReps, f5a(n, aRate, sRate))
}

f5c = function(nReps, n, aRate, sRate) {
  a = matrix(rexp(nReps * n, aRate), n, nReps)
  s = matrix(rexp(nReps * n, sRate), n, nReps)
  w = rep(0, nReps)
  for (i in 1:n) {
    w = pmax(0, w + s[i,] - a[i,])
  }
  w
}


rwalk_a = function(n) {
  x = c(0, sample(c(1,-1), n, replace=TRUE, prob=c(0.5,0.5)))
  cumsum(x)
}

rwalk_b = function(n) {
  x = c(0, sample(c(1,-1), n, replace=TRUE, prob=c(0.5,0.5)))
  w = cumsum(x)
  sum(w[-(n+1)] + w[-1] > 0)
}

rwalk_c1 = function(nReps, n) {
  results = rep(NA, nReps)
  for (i in 1:nReps) {
    results[i] = rwalk_b(n)
  }
  results
}

rwalk_c2 = function(nReps, n) {
  replicate(nReps, rwalk_b(n))
}

rwalk_d = function(nReps, n) {
  stepWalks = matrix(sample( c(-1,1), n, replace=TRUE, prob=c(0.5,0.5)), nr=nReps)
  for(j in 2:n)
    stepWalks[,j] = stepWalks[,j] + stepWalks[,j-1]
  stepWalks = cbind(0, stepWalks)
  rowSums(stepWalks[,1:n] + stepWalks[,2:(n+1)] > 0)
}
