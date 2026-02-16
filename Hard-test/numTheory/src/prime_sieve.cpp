#include <Rcpp.h>
#include <cmath>       
using namespace Rcpp;
using namespace std;

// [[Rcpp::export]]
IntegerVector prime_sieve(double n) {  // R by default considers numeric values as double
  try {
    // parse to Integer 
    long long N = (long long) llround(n);

    if (N < 2) {
      stop("prime_sieve() requires n >= 2.");
    }

    vector<bool> is_prime(N + 1, true);
    is_prime[0] = is_prime[1] = false;

    for (long long p = 2; p * p <= N; p++) {
      if (is_prime[p]) {
        for (long long i = p * p; i <= N; i += p) {
          is_prime[i] = false;
        }
      }
    }

    vector<int> primes;
    for (long long i = 2; i <= N; i++) {
      if (is_prime[i]) primes.push_back((int)i);
    }

    return wrap(primes);

  } catch (std::exception &ex) {
    stop("Error in prime_sieve(): %s", ex.what());
  } catch (...) {
    stop("Unknown error in prime_sieve().");
  }
}
