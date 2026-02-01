# EASY_TEST 

# USED_PACKAGES:
1) "glmmTMB" (version: ‘1.1.14’)
2) "lme4" (version: ‘1.1.38’)
3) "ggplot2" (version: ‘4.0.1’)

# Summary ***Salamanders*** datasets:
**"The Salamanders dataset is indeed a preinstalled example dataset that comes with the glmmTMB package.":**
[!link](results/Salamanders_summary.html)


# Head ***Salamanders*** datasets:
[!link](results/Salamanders_head.html)


# Results:
1) Model_1 (Standard GlmmTMB  Poisson model) :
    [!link](results/Salamanders_model1.html)  

2) Model_2 (Zero-inflated  GLmmTMB poisson  model):

    [!link](results/Salamanders_model2_cond.html)

    [!link](results/Salamanders_model2_zi.html)
    

3) Model_3 (Binomial GLmmTMB model):
    [!link](results/Salamanders_model3.html)

4) Model_4 (Standard lme4 model):
    [!link](results/Salamanders_model4.html)

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



