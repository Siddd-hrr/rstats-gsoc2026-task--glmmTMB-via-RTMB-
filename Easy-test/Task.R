# Used pkg:- glmmTMB , lme4 and ggplot2 
library(glmmTMB)
library(lme4)
library(ggplot2)

# cat("\nPackage versions:\n")
# cat("glmmTMB:", packageVersion("glmmTMB"), "\n")
# cat("lme4:", packageVersion("lme4"), "\n")
# cat("ggplot2:", packageVersion("ggplot2"), "\n")

# Salamanders dataset summary: 
print(summary(Salamanders))


# Model 1 Standard Poisson model 
m1 <- glmmTMB(count ~ mined + (1|site), family = poisson, data = Salamanders)  

# Model 2  Zero-inflated   poisson  model
m2 <- glmmTMB(count ~ mined + (1|site), ziformula = ~ mined, family = poisson, data = Salamanders)

# Model 3 Binomial  model 
m3 <- glmmTMB(cbind(incidence, size - incidence) ~ period + (1|herd), family = binomial, data = cbpp)   

# Result : Model 1 summary: 
print(summary(m1)$coefficients$cond)

# Result : Model 2 Zero-inflated poisson summary: 
print(summary(m2)$coefficients$cond)  #Conditional 
print(summary(m2)$coefficients$zi)    #zi-formula 
cat("AIC comparison: m1 =", AIC(m1), " m2 =", AIC(m2), "\n")

#Result : Model 3 Binomial summary: 
print(summary(m3)$coefficients$cond)


#Model 4 : Standard lme4 model
m1_lme4 <- glmer(count ~ mined + (1|site), family = poisson, data = Salamanders) 

# Result: Model 4 Standard lme4 model: 
print(summary(m1_lme4))



site_effects <- ranef(m1)$cond$site
p  <- ggplot(data.frame(site = rownames(site_effects), effect = site_effects[,1]),
       aes(x = site, y = effect)) +
  geom_point() +
  labs(title = "Random Site Effects on Salamander Counts")
ggsave("random_effe_plot.png", p, width = 8, height = 6)