mA = matrix(c(1, 4, 7,
              2, 4, 8,
              6, 1, 3), nrow=3, ncol=3, byrow=TRUE)

mB = matrix(c(4, 4, 0,
              5, 9, 1,
              2, 2, 5), nrow=3, ncol=3, byrow=TRUE)

vX = c(1, 2, 3)
vY = c(5, 2, 7)

# Q1-9
(q1 = t(mA))
(q2 = t(mB))
(q3 = t(vX))
(q4 = t(vY))
(q5 = mA + mB)
(q6 = mA - mB)
(q7 = 2 * mA)
(q8 = mA %*% vX)
(q9 = t(vY) %*% mA %*% vX)

# Q10
A = matrix(c(1, 1,
            2, 4), nrow=2, ncol=2, byrow=TRUE)
b = c(1, 2)
(q10 = solve(A) %*% b)

# Q11-12
mu = c(0.01, 0.04, 0.02)
Sigma = matrix(c(0.10, 0.30, 0.10,
                 0.30, 0.15, -0.20,
                 0.10, -0.20, 0.08), nrow=3, ncol=3, byrow=TRUE)
w = c(1, 1, 1) / 3
(q11 = sum(mu * w))
(q12 = t(w) %*% Sigma %*% w)
