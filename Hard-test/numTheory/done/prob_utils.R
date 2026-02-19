## ----echo=TRUE, results='verbatim'--------------------------------------------
library(numTheory)

# Standard normal density at x = 0
normal_pdf(0, mean = 0, sd = 1)     

# Density at x = 1.96 (approx. 95% cutoff)
normal_pdf(1.96, mean = 0, sd = 1)

## ----echo=TRUE, results='verbatim'--------------------------------------------
library(numTheory)

# Probability that a standard normal variable <= 0
normal_cdf(0, mean = 0, sd = 1)

# Probability that a standard normal variable <= 1.96
normal_cdf(1.96, mean = 0, sd = 1) 

