#' Modular Exponentiation
#' Computes (base^exp) mod mod efficiently.
#' @param base Integer base
#' @param exp Integer exponent
#' @param mod Integer modulus
#' @return Integer result of (base^exp) mod 
#' @export
mod_exp <- function(base, exp, mod) {
  .Call(`_numTheory_mod_exp`, base, exp, mod)
}
