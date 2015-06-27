expect = function(p) {
  vals = t(1:length(p))
  sum(p * vals)
}

# var(x) = E(x-E(x))^2
var = function(p) {
  mu = expect(p)
  shifted = t((1:length(p) - mu)^2)
  sum(p * shifted)
}

# cov(x, y) = E(xy) - E(x)E(y)
cov = function(m, margX, margY) {
  vals = 1:nrow(m)
  joint = t(vals * t(vals * m))
  sum(joint) - expect(margX) * expect(margY)
}

m = matrix(c(0.1, 0.2, 0,
             0.1, 0, 0.2,
             0, 0.1, 0.3),
           nrow=3, ncol=3, byrow=T)
marginalX = rowSums(m)
marginalY = colSums(m)

# Q1-8
(q1 = expect(marginalX))
(q2 = expect(marginalY))
(q3 = var(marginalX))
(q4 = var(marginalY))
(q5 = sqrt(q3))
(q6 = sqrt(q4))
(q7 = cov(m, marginalX, marginalY))
(q8 = q7 / (q5 * q6))

# Q10
cc_to_simple = function(r) exp(r) - 1
w = 100000
(cc_var1 = cc_to_simple(qnorm(0.01, mean=0.04*12, sd=0.09*sqrt(12))) * w)
(cc_var5 = cc_to_simple(qnorm(0.05, mean=0.04*12, sd=0.09*sqrt(12))) * w)
