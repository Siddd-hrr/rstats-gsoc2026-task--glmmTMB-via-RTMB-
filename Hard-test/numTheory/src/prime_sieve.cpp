#include <Rcpp.h>
using namespace Rcpp;


IntegerVector prime_sieve(double n_in) {
  try {
    // parse to Integer 
    long long n = (long long)std::llround(n_in);

    if (n < 2) {
      stop("prime_sieve() requires n >= 2.");
    }

    std::vector<bool> is_prime(n+1, true);
    is_prime[0] = is_prime[1] = false;

    for (long long p = 2; p * p <= n; p++) {
      if (is_prime[p]) {
        for (long long i = p * p; i <= n; i += p) {
          is_prime[i] = false;
        }
      }
    }

    std::vector<int> primes;
    for (long long i = 2; i <= n; i++) {
      if (is_prime[i]) primes.push_back((int)i);
    }

    return wrap(primes);

  } catch (std::exception &ex) {
    stop("Error in prime_sieve(): %s", ex.what());
  } catch (...) {
    stop("Unknown error in prime_sieve().");
  }
}
