#include <Rcpp.h>
#include <cmath>
using namespace Rcpp;


double normal_pdf(double x, double mean, double sd) {
  try {
    if (sd <= 0) {
      stop("normal_pdf() requires sd > 0.");
    }
    double coeff = 1.0 / (sd * std::sqrt(2.0 * M_PI));
    double exponent = -0.5 * std::pow((x - mean) / sd, 2);
    return coeff * std::exp(exponent);
  } catch (std::exception &ex) {
    stop("Error in normal_pdf(): %s", ex.what());
  } catch (...) {
    stop("Unknown error in normal_pdf().");
  }
}


double normal_cdf(double x, double mean, double sd) {
  try {
    if (sd <= 0) {
      stop("normal_cdf() requires sd > 0.");
    }
    double z = (x - mean) / (sd * std::sqrt(2.0));
    return 0.5 * (1.0 + std::erf(z));
  } catch (std::exception &ex) {
    stop("Error in normal_cdf(): %s", ex.what());
  } catch (...) {
    stop("Unknown error in normal_cdf().");
  }
}
