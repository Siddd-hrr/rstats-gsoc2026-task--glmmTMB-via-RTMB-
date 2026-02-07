#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
long long gcd_cpp(NumericVector input) {
  try {
    if (input.size() != 2) {
      stop("gcd_cpp() requires exactly two numeric inputs.");
    }

    // parse  to integer 
    long long a = (long long)std::llround(input[0]);
    long long b = (long long)std::llround(input[1]);

    if (a == 0 && b == 0) {
      stop("gcd_cpp() undefined for both inputs equal to zero.");
    }

    a = std::abs(a);
    b = std::abs(b);

    while (b != 0) {
      long long temp = b;
      b = a % b;
      a = temp;
    }
    return a;

  } catch (std::exception &ex) {
    stop("Error in gcd_cpp(): %s", ex.what());
  } catch (...) {
    stop("Unknown error in gcd_cpp().");
  }
}
