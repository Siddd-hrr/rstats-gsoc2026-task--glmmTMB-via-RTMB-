### R code from vignette source 'cor_cov.Rnw'

###################################################
### code chunk number 1: cor_cov.Rnw:29-36
###################################################
library(numTheory)

x <- c(1,2,3,4,5)
y <- c(2,4,6,8,10)

# Correlation and covariance of x and y
cor_cov(x, y)


###################################################
### code chunk number 2: cor_cov.Rnw:43-47
###################################################
# Perfect proportionality: y = 2x
x <- c(1,2,3,4,5)
y <- 2 * x
cor_cov(x, y)


###################################################
### code chunk number 3: cor_cov.Rnw:53-60
###################################################
# Zero variance in y
y2 <- c(5,5,5,5,5)
cor_cov(x, y2)

# Mismatched lengths (expected: error)
y3 <- c(1,2,3)
try(cor_cov(x, y3))


