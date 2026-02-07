#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List cor_cov_cpp(NumericVector x, NumericVector y) {
  try {
    if (x.size() != y.size()) {
      stop("cor_cov_cpp() requires vectors of equal length.");
    }
    int n = x.size();
    if (n < 2) {
      stop("cor_cov_cpp() requires at least two observations.");
    }

    double mean_x = mean(x);
    double mean_y = mean(y);

    double cov = 0.0, var_x = 0.0, var_y = 0.0;
    for (int i = 0; i < n; i++) {
      cov += (x[i] - mean_x) * (y[i] - mean_y);
      var_x += (x[i] - mean_x) * (x[i] - mean_x);
      var_y += (y[i] - mean_y) * (y[i] - mean_y);
    }

    cov /= (n - 1);
    double cor = cov / std::sqrt((var_x / (n - 1)) * (var_y / (n - 1)));

    return List::create(
      _["covariance"] = cov,
      _["correlation"] = cor
    );
  } catch (std::exception &ex) {
    stop("Error in cor_cov_cpp(): %s", ex.what());
  } catch (...) {
    stop("Unknown error in cor_cov_cpp().");
  }
}
