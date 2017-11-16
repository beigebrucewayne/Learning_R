library(car)

data(Quartet)

head(Quartet)

# str() structure of data
str(Quartet)

plot(Quartet$x, Quartet$y1)
lmfit  <- lm(y1 ~ x, Quartet)
abline(lmfit, col = "red")

lmfit

summary(lmfit)

# coefficients(lmfit) -> extract model coefficients
# confint(lmfit, level = 0.95) -> compute CI intervals
# fitted(lmfit) -> extract model fitted values
# residuals(lmfit) -> extract model residuals
# anvoa(lmfit) -> compute analysis of variance tables
# vcov(lmfit) -> calc variance-covariance matrix
# influence(lmfit) -> diagnose quality of regression fits


### PREDICT UNKNOWN VALUES ###

lmfit  <- lm(y1 ~ x, Quartet)

# values to be predicted
new.data  <- data.frame(x = c(3, 6, 15))

predict(lmfit, new.data, interval = "confidence", level = 0.95)

### DIAGNOSISTIC PLOT ###

par(mfrow = c(2, 2))
plot(lmfit)

### Multiple Regression ###

head(Prestige)
str(Prestige)
attach(Prestige)

model  <- lm(income ~ prestige + women)
scatter3d(income ~ prestige + women, Prestige)

summary(model)

### MULTIPLE REGRESSION -> PREDICT ###

new.dat  <- data.frame(prestige = c(75, 80), women = c(14, 13))

predict(model, newdata = new.dat)
predict(model, newdata = new.dat, interval = "predict")

### POLYNOMIAL REGRESSION ###


lmfit  <- lm(Quartet$y2 ~ poly(Quartet$x, 2))

plot(Quartet$x, Quartet$y2)
lines(sort(Quartet$x), lmfit$fit[order(Quartet$x)], col = "red")

### ROBUST LINEAR REGRESSION ###

# for datasets with outliers

library(MASS)
lmfit  <- rlm(Quartet$y3 ~ Quartet$x)

### GAUSSIAN LINEAR REGRESSION ###

lmfit1  <- glm(wages ~ age + sex + education, data = SLID, family = gaussian)
summary(lmfit1)
lmfit2  <- lm(wages ~ age + sex + education, data= SLID)
summary(lmfit2)

anova(lmfit1, lmfit2)

### GENERALIZED ADDITIVE MODEL ####

library(MASS)

attach(Boston)
str(Boston)

fit  <- gam(dis ~ s(nox))

summary(fit)

### SURVIVAL ANALYSIS ###

library(survival)
data(cancer)

# survfit function, create survival curve
sfit  <- survfit(Surv(time, status) ~ sex, data = cancer)
sfit
summary(sfit)

library(survminer)

hist(cancer$time, xlab = "Survival Time", main = "Histogram of Survival Time")

# survival by gender
s  <- Surv(cancer$time, cancer$status)
sfit  <- survfit(Surv(time, status) ~ sex, data = cancer)

plot(sfit)
ggsurvplot(sfit)

ggsurvplot(sfit, risk.table = TRUE, legend.labs = c("Male", "Female"))

# survival rate by institute
ggsurvplot(survfit(Surv(time, status) ~ inst, data = cancer))

# log-rank test -> calc differences between curves
survdiff(Surv(cancer$time, cancer$status) ~ cancer$sex)

### COX PROPORTIONAL HAZARD REGRESSION ###

coxph(formula = Surv(time, status) ~ sex, data = cancer)
coxph(formula = Surv(time, status) ~ sex + age, data = cancer)
c <- coxph(formula = Surv(time, status) ~ sex + age + meal.cal, data = cancer)
# get hazard ratio
exp(c$coef)

# Hazard Ratio
# 1 == No effect
# > 1 == Increased Hazard
# < 1 == Reduced Hazard

# Nelson-Aalen Estimator -> cumulative hazard
sfitall  <- survfit(Surv(time, status) ~ 1, data = cancer)
c  <- coxph(formula = Surv(time, status) ~ 1, data = cancer)
n  <- basehaz(c)
plot(n)
