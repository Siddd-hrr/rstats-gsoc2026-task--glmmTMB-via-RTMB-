#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
long long mod_exp(double base_in, double exp_in, double mod_in) {
  try {
    // parse to integer 
    long long base = (long long)std::llround(base_in);
    long long exp  = (long long)std::llround(exp_in);
    long long mod  = (long long)std::llround(mod_in);

    if (mod <= 0) {
      stop("mod_exp() requires modulus > 0.");
    }
    if (exp < 0) {
      stop("mod_exp() does not support negative exponents.");
    }

    long long result = 1;
    long long b = base % mod;

    while (exp > 0) {
      if (exp % 2 == 1) {
        result = (result * b) % mod;
      }
      b = (b * b) % mod;
      exp /= 2;
    }

    return result;

  } catch (std::exception &ex) {
    stop("Error in mod_exp(): %s", ex.what());
  } catch (...) {
    stop("Unknown error in mod_exp().");
  }
}
