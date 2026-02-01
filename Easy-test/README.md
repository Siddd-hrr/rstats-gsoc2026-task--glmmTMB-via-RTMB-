# EASY_TEST 

# USED_PACKAGES:
1) "glmmTMB" (version: ‘1.1.14’)
2) "lme4" (version: ‘1.1.38’)
3) "ggplot2" (version: ‘4.0.1’)

# Summary ***Salamanders*** datasets:
**"The Salamanders dataset is indeed a preinstalled example dataset that comes with the glmmTMB package.":**
[link](results/Salamanders_summary.html)
|   |     site   |mined   |    cover        |    sample   |     DOP        |    Wtemp       |     DOY        |   spp   |    count      |
|:--|:-----------|:-------|:----------------|:------------|:---------------|:---------------|:---------------|:--------|:--------------|
|   |R-1    : 28 |yes:308 |Min.   :-1.59152 |Min.   :1.00 |Min.   :-2.1984 |Min.   :-3.0234 |Min.   :-2.7122 |GP   :92 |Min.   : 0.000 |
|   |R-2    : 28 |no :336 |1st Qu.:-0.69629 |1st Qu.:1.75 |1st Qu.:-0.3018 |1st Qu.:-0.6139 |1st Qu.:-0.5653 |PR   :92 |1st Qu.: 0.000 |
|   |R-3    : 28 |NA      |Median :-0.04974 |Median :2.50 |Median :-0.0916 |Median : 0.0370 |Median :-0.0590 |DM   :92 |Median : 0.000 |
|   |R-4    : 28 |NA      |Mean   : 0.00000 |Mean   :2.50 |Mean   : 0.0000 |Mean   : 0.0000 |Mean   : 0.0000 |EC-A :92 |Mean   : 1.323 |
|   |R-5    : 28 |NA      |3rd Qu.: 0.59682 |3rd Qu.:3.25 |3rd Qu.: 0.0000 |3rd Qu.: 0.6032 |3rd Qu.: 0.9739 |EC-L :92 |3rd Qu.: 2.000 |
|   |R-6    : 28 |NA      |Max.   : 1.88993 |Max.   :4.00 |Max.   : 3.1691 |Max.   : 2.2094 |Max.   : 1.4600 |DES-L:92 |Max.   :36.000 |
|   |(Other):476 |NA      |NA               |NA           |NA              |NA              |NA              |DF   :92 |NA             |



# Head ***Salamanders*** datasets:
[link](results/Salamanders_head.html)
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
    [link](results/Salamanders_model1.html)  
    |            |  Estimate| Std. Error|   z value| Pr(>&#124;z&#124;)|
    |:-----------|---------:|----------:|---------:|------------------:|
    |(Intercept) | -1.505325|  0.2230325| -6.749354|                  0|
    |minedno     |  2.264413|  0.2802558|  8.079809|                  0|


2) Model_2 (Zero-inflated  GLmmTMB poisson  model):

    [link](results/Salamanders_model2_cond.html)
    |            |  Estimate| Std. Error|   z value| Pr(>&#124;z&#124;)|
    |:-----------|---------:|----------:|---------:|------------------:|
    |(Intercept) | 0.0878965|  0.2328797| 0.3774331|          0.7058517|
    |minedno     | 1.1419232|  0.2461495| 4.6391444|          0.0000035|


    [link](results/Salamanders_model2_zi.html)
    |            |  Estimate| Std. Error|   z value| Pr(>&#124;z&#124;)|
    |:-----------|---------:|----------:|---------:|------------------:|
    |(Intercept) |  1.139304|  0.2350875|  4.846300|            1.3e-06|
    |minedno     | -1.736067|  0.2620003| -6.626201|            0.0e+00|

    

3) Model_3 (Binomial GLmmTMB model):
    [link](results/Salamanders_model3.html)
    |            |   Estimate| Std. Error|   z value| Pr(>&#124;z&#124;)|
    |:-----------|----------:|----------:|---------:|------------------:|
    |(Intercept) | -1.3985325|  0.2324721| -6.015917|          0.0000000|
    |period2     | -0.9923323|  0.3066425| -3.236121|          0.0012117|
    |period3     | -1.1286713|  0.3266378| -3.455421|          0.0005494|
    |period4     | -1.5803137|  0.4274366| -3.697189|          0.0002180|


4) Model_4 (Standard lme4 model):
    [link](results/Salamanders_model4.html)
    |            |  Estimate| Std. Error|   z value| Pr(>&#124;z&#124;)|
    |:-----------|---------:|----------:|---------:|------------------:|
    |(Intercept) | -1.504635|  0.2211113| -6.804876|                  0|
    |minedno     |  2.263738|  0.2786964|  8.122594|                  0|


# AIC Comparsion 
**(Standard GlmmTMB  Poisson model ***Model_1*** V/s Zero-inflated  GLmmTMB poisson  model **Model_2***)**:
AIC comparison: m1 = 2215.699  m2 = 1908.47




# Visualization 

***Note***: 
1) Each dot := one site from the Salamanders dataset.
2) The y‑axis shows how much that site’s salamander counts differ from the overall average.
3) Positive values -> sites with higher counts than expected.
4) Negative values -> sites with lower counts than expected.
5) Shows which sites have higher or lower salamander counts compared to the average.
 
![Random Effects Plot](plots/random_effe_plot.png)



