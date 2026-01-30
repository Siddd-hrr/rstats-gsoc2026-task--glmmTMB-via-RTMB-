# EASY_TEST 

# USED_PACKAGES:
1) "glmmTMB" (version: ‘1.1.14’)
2) "lme4" (version: ‘1.1.38’)
3) "ggplot2" (version: ‘4.0.1’)

# Summary ***Salamanders*** datasets:
"The Salamanders dataset is indeed a preinstalled example dataset that comes with the glmmTMB package."


# head ***Salamanders*** datasets:
|site |mined |      cover| sample|        DOP|      Wtemp|       DOY|spp | count|
|:----|:-----|----------:|------:|----------:|----------:|---------:|:---|-----:|
|VF-1 |yes   | -1.4423172|      1| -0.5956834| -1.2293786| -1.497003|GP  |     0|
|VF-2 |yes   |  0.2984104|      1| -0.5956834|  0.0847653| -1.497003|GP  |     0|
|VF-3 |yes   |  0.3978806|      1| -1.1913668|  1.0141763| -1.294467|GP  |     0|
|R-1  |no    | -0.4476157|      1|  0.0000000| -3.0233580| -2.712216|GP  |     2|
|R-2  |no    |  0.5968209|      1|  0.5956834| -0.1443453| -0.686860|GP  |     2|
|R-3  |no    |  1.3428470|      1|  0.5956834| -0.0146601| -0.686860|GP  |     1|


# Results:
1) Model_1 (Standard GlmmTMB  Poisson model) :  

2) Model_2 (Zero-inflated  GLmmTMB poisson  model):

3) Model_3 (Binomial GLmmTMB model):

4) Model_4 (Standard lme4 model):

# AIC Comparsion (Standard GlmmTMB  Poisson model ***Model_1*** V/s Zero-inflated  GLmmTMB poisson  model ***Model_2*** ):



# Visualization 

***Note***: 
1) Each dot := one site from the Salamanders dataset.
2) The y‑axis shows how much that site’s salamander counts differ from the overall average.
3) Positive values -> sites with higher counts than expected.
4) Negative values -> sites with lower counts than expected.
5) Shows which sites have higher or lower salamander counts compared to the average.
 
![Random Effects Plot](plots/random_effe_plot.png)



