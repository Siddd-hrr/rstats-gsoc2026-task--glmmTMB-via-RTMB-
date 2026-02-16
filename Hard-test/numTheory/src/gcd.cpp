#include <Rcpp.h>
#include<cmath>
using namespace Rcpp;
using namespace std; 

// [[Rcpp::export]]
long long gcd_cpp(NumericVector input) {
  try {
    if (input.size() != 2) {
      stop("gcd_cpp() requires exactly two numeric inputs.");
    }

    // parse  to integer 
    long long a = (long long) llround(input[0]);
    long long b = (long long) llround(input[1]);

    if (a == 0 && b == 0) {
      stop("gcd_cpp() undefined for both inputs equal to zero.");
    }

    a =  abs(a);
    b =  abs(b);

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
