# gcd 
test_that("gcd_cpp test Successfull", {
  expect_equal(gcd_cpp(48, 18), 6)
  expect_equal(gcd_cpp(101, 10), 1)
  expect_error(gcd_cpp(0, 0)) # invalid case
})

test_that("prime_sieve test Successfull", {
  expect_equal(prime_sieve(10), c(2,3,5,7))
  expect_error(prime_sieve(1)) # invalid case
})

test_that("mod_exp test Successfull", {
  expect_equal(mod_exp(2, 10, 1000), 24)
  expect_equal(mod_exp(3, 7, 13), 3^7 %% 13)
  expect_error(mod_exp(2, -1, 5)) # invalid case 
})

# Probability Utilities
test_that("normal_pdf test Successfull", {
  expect_equal(round(normal_pdf(0, 0, 1), 5), 0.39894)
  expect_error(normal_pdf(0, 0, -1)) # invalid case 
})

test_that("normal_cdf test Succcessfull", {
  expect_equal(round(normal_cdf(0, 0, 1), 5), 0.5)
  expect_equal(round(normal_cdf(1.96, 0, 1), 3), 0.975)
  expect_error(normal_cdf(0, 0, 0)) # invalid case 
})

# Correlation & Covariance
test_that("cor_cov test Successfull", {
  x <- c(1,2,3,4,5)
  y <- c(2,4,6,8,10)
  res <- cor_cov(x, y)
  expect_true(abs(res$correlation - 1) < 1e-10)
  expect_true(res$covariance > 0)
})

test_that("cor_cov errors on unequal length", {
  expect_error(cor_cov(c(1,2,3), c(1,2)))
})

test_that("cor_cov errors on too low observations data", {
  expect_error(cor_cov(c(1), c(2)))
})
