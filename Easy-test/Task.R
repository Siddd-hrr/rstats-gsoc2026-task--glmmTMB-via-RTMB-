# Used pkg:- glmmTMB , lme4 and ggplot2 
library(glmmTMB)
library(lme4)
library(ggplot2)
library(knitr)
library(htmltools)




# Salamanders dataset summary: 
print(kable(summary(Salamanders), format = "markdown"))
writeLines(kable(summary(Salamanders,format = "html")), "Easy-test/Salamanders_summary.html")



#Salamanders dataset head:
print(kable(head(Salamanders),format = "markdown"))
writeLines(kable(head(Salamanders,format = "html")), "Easy-test/Salamanders_head.html")




# Model 1 Standard GlmmTMB  Poisson model 
m1 <- glmmTMB(count ~ mined + (1|site), family = poisson, data = Salamanders)  

# Model 2  Zero-inflated  GLmmTMB poisson  model
m2 <- glmmTMB(count ~ mined + (1|site), ziformula = ~ mined, family = poisson, data = Salamanders)

# Model 3 Binomial GLmmTMB model 
m3 <- glmmTMB(cbind(incidence, size - incidence) ~ period + (1|herd), family = binomial, data = cbpp)   

# Result : Model 1 summary: 
print(kable(summary(m1)$coefficients$cond, format = "markdown"))
writeLines(kable(head(Salamanders,format = "html")), "Easy-test/Salamanders_model1.html")


# Result : Model 2 Zero-inflated poisson summary: 
  #Conditional:
  print(kable(summary(m2)$coefficients$cond, format = "markdown"))  
  writeLines(kable(summary(m2)$coefficients$cond, format = "html"), "Easy-test/Salamanders_model2_cond.html")

  #zi-formula 
  print(kable(summary(m2)$coefficients$zi, format = "markdown"))    
  writeLines(kable(summary(m2)$coefficients$zi, format = "html"), "Easy-test/Salamanders_model2_zi.html")
  
  cat("AIC comparison: m1 =", AIC(m1), " m2 =", AIC(m2), "\n")

#Result : Model 3 Binomial summary: 
print(kable(summary(m3)$coefficients$cond, format = "markdown"))
writeLines(kable(summary(m3)$coefficients$cond, format = "html"), "Easy-test/Salamanders_model3.html")


#Model 4 : Standard lme4 model
m1_lme4 <- glmer(count ~ mined + (1|site), family = poisson, data = Salamanders) 

# Result: Model 4 Standard lme4 model: 
print(kable(summary(m1_lme4)$coefficients, format = "markdown"))
writeLines(kable(summary(m1_lme4)$coefficients, format = "html"), "Easy-test/Salamanders_model4.html")

#Visualization 
site_effects <- ranef(m1)$cond$site
df_site <- data.frame(site = rownames(site_effects), effect = site_effects[,1])

p <-ggplot(df_site, aes(x = site, y = effect, group = 1)) +
    geom_point(color = "black") +                     
    geom_line(color = "blue") +                      
    geom_hline(yintercept = 0, linetype = "dashed") +
    labs(title = "Random Site Effects on Salamander Counts",
      x = "Site",
      y = "Random Effect Estimate") +
    theme_minimal()                                  

ggsave("Easy-test/random_effe_plot.png", p, width = 8, height = 6)
