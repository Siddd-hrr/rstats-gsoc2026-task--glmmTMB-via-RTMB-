# Greatest Common Divisor
#' @param a First input(integer)
#' @param b Second input(integer)
#' @return GCD of a and b
#' @export
gcd_cpp <- function(a, b) {
  .Call(`_numTheory_gcd_cpp`, c(a,b))
}
