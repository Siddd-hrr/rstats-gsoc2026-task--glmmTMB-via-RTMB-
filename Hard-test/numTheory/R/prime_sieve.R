#' Generate prime numbers up to n
#' @param n Integer upper limit
#' @return Integer vector of primes <= n
#' @examples
#' @export
prime_sieve <- function(n) {
  .Call(`_numTheory_prime_sieve`, n)
}
