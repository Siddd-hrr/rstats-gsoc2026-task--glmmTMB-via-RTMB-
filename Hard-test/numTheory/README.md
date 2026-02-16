## HARD-Test

## PACKAGE_AUTHOR: 
Siddhesh Akole

## PACKAGE_NAME: 
numTheory

---

### Prerequisites
- R (version 4.0 or higher)
- Rtools (Windows) or build-essential (Linux)

---

### Instructions_to_install_package:
-   **Step1: Install devtools if not already installed:**
    ```bash
    install.packages("devtools") 
    ```
-   **Step2:** 
    ```bash
    devtools::install_github("Siddd-hrr/rstats-gsoc2026-task--glmmTMB-via-RTMB-/Hard-test/numTheory") 
    ```
-   **Step3:**  
    ```bash
    library("numTheory")
    ```

---

### Functions_numTheory_provide:

1) [gcd](src/gcd.cpp): Computes the greatest common divisor of two integers.

    - [vignette_gcd](src/vignette/gcd.Rnw) 
    ```bash 
    vignette("gcd", package = "numTheory")
    ```
    - Syntax : 
    ```bash
    gcd_cpp(a,b)
    ```
2) [mod_exp](src/mod_exp.cpp): Performs modular exponentiation using fast exponentiation.

    - [vignette_mod_exp](src/vignette/mod_exp.Rnw)
    ```bash 
    vignette("mod_exp", package = "numTheory")
    ``` 
    - Syntax: 
    ```bash
    mod_exp(base, exp, mod)
    ```
3) [prime_sieve](src/prime_sieve.cpp): Generates all prime numbers up to n using the Sieve of Eratosthenes.

    - [vignette_prime_sieve](src/vignette/prime_sieve.Rnw)
    ```bash
    vignette("prime_sieve", package = "numTheory") 
    ```
    - Syntax: 
    ```bash
    prime_sieve(n) 
    ```
4) [cor_cov](src/cor_cov.cpp): Computes both correlation and covariance between two numeric vectors.

    - [vignette_cor_cov](src/vignette/cor_cov.Rnw)
    ```bash 
    vignette("cor_cov", package = "numTheory")
    ``` 
    - Syntax: 
    ```bash
    cor_cov(x, y)
    ```
5) [normal_pdf](src/prob_utils.cpp): Evaluates the probability density function of the normal distribution.

    - [vignette_normal_pdf](src/vignette/prob_utils.Rnw)
    ```bash  
    vignette("prob_util", package = "numTheory") 
    ```
    - Syntax
    ```bash
    normal_pdf(x, mean, sd)
    ```
6) [normal_cdf](src/prob_utils.cpp): Evaluates the cumulative distribution function of the normal distribution.

    - [vignette_normal_cdf](src/vignette/prob_utils.Rnw)
    ```bash  
    vignette("prob_util", package = "numTheory") 
    ```
    - Syntax: 
    ```bash
    normal_cdf(x, mean, sd)
    ```

---

###  list all the vignette package available.
```bash 
vignette(package = "numTheory")
```

---

### Testing & Validation

To verify that the package builds and all functions work correctly, run:
```bash
R CMD check numTheory
```

or 

```bash 
library(devtools)
```
```bash
check("numTheory")
```

---







 



