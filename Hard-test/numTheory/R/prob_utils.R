#' Normal PDF
#'
#' Computes the probability density function of the normal distribution.
#'
#' @param x Numeric value
#' @param mean Mean of the distribution (default = 0)
#' @param sd Standard deviation (default = 1)
#' @return Numeric density value
#' @export
normal_pdf <- function(x, mean = 0, sd = 1) {
  .Call(`_numTheory_normal_pdf`, x, mean, sd)
}

#' Normal CDF
#'
#' Computes the cumulative distribution function of the normal distribution.
#'
#' @param x Numeric value
#' @param mean Mean of the distribution (default = 0)
#' @param sd Standard deviation (default = 1)
#' @return Probability that a normal random variable <= x
#' @export
normal_cdf <- function(x, mean = 0, sd = 1) {
  .Call(`_numTheory_normal_cdf`, x, mean, sd)
}
