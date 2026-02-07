#' Correlation and Covariance
#'
#' Computes covariance and correlation between two numeric vectors.
#'
#' @param x Numeric vector
#' @param y Numeric vector of same length
#' @return A list with covariance and correlation
#' @export
cor_cov <- function(x, y) {
  .Call(`_numTheory_cor_cov_cpp`, x, y)
}
