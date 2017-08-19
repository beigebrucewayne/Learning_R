library(MASS)
library(tidyverse)
head(Boston)
# fit simple linear regression model
lm.fit  <- lm(medv ~ lstat, data=Boston)
lm.fit
summary(lm.fit)
names(lm.fit)
coef(lm.fit)
# confidence interval
confint(lm.fit)
lstat.view  <- Boston %>%
  select(lstat)
predict(lm.fit, data.frame(lstat=(c(5,10,15))), interval="confidence")
predict(lm.fit, data.frame(lstat=(c(5,10,15))), interval="prediction")
# plot medv + lstat along with least squares regression line
ggplot(lm.fit, aes(lstat, medv)) + geom_point() + geom_smooth(method=lm)
lstat.medv.plot  <- lm.fit %>%
  ggplot(aes(lstat, medv)) +
  geom_point() +
  geom_smooth(method=lm)


# use multiplot() to view multiple graphs at once 
library(ggthemes)
p1  <- ggplot(lm.fit, aes(predict(lm.fit), residuals(lm.fit)), color="darkunica") + geom_point() + theme_hc(bgcolor="darkunica")
p2  <- ggplot(lm.fit, aes(predict(lm.fit), rstudent(lm.fit))) + geom_point() + theme_hc(bgcolor="darkunic")
# leverage stats can be computed for any number of predictors using hatvalues()
p3  <- ggplot(lm.fit, aes(hatvalues(lm.fit), color="darkunica")) + geom_density() + theme_hc(bgcolor="darkunica")
# which.max() - identifies index of largest element of a vector - which obs has largest leverage statistic
which.max(hatvalues(lm.fit))


### multiple linear regression ###

multiple.lm.fit  <- lm(medv ~ lstat + age, data=Boston)
summary(multiple.lm.fit)

# regression using all the predictors
all.lm.fit  <- lm(medv ~ ., data=Boston)
summary(all.lm.fit)
# RSE
summary(all.lm.fit)$sigma
# vif test()
library(car)
vif(all.lm.fit)
# re-run regression without age, since high p-value
no.age.lm.fit  <- lm(medv ~ .-age, data=Boston)
summary(no.age.lm.fit)
library(coefplot)
coefplot(all.lm.fit)
coefplot(no.age.lm.fit)
# coefplot houses multiplot
multiplot(all.lm.fit, no.age.lm.fit)
# using update function to change model
lm.fit1=update(lm.fit, ~ .-age)


### INTERACTION TERMS ###

summary(lm(medv ~ lstat*age, data=Boston))

### NON-LINEAR TRANSFORMATIONS OF PREDICTORS ###

# use I() - changes class to indicate variable should be treated 'as is'
lm.fit2  <- lm(medv ~ lstat + I(lstat^2), data=Boston)
summary(lm.fit2)
lm.fit  <- lm(medv ~ lstat, data=Boston)
anova(lm.fit, lm.fit2)
c.lm  <- coefplot(lm.fit)
c.lm2  <- coefplot(lm.fit2)

# polynomial regression
# fifth-order polynomial fit
lm.fit5  <- lm(medv ~ poly(lstat, 5), data=Boston)
summary(lm.fit5)
anova(lm.fit2, lm.fit5)

# graphing lm.fit5
lmf5  <- ggplot(lm.fit5, aes(residuals(lm.fit5), predict(lm.fit5), color="darkunica")) + geom_point() + geom_smooth() + theme_hc(bgcolor="darkunica")

# using log() transformation
summary(lm(medv ~ log(rm), data=Boston))

### QUALITATIVE PREDICTORS ###

lm.fit  <- lm(Sales ~ .+Income:Advertising+Price:Age, data=Carseats)
summary(lm.fit)
# contrasts() - returns coding that R uses for dummy variable
contrasts(ShelveLoc) # dummy variables for qualitative variables

### WRITING FUNCTIONS ###

LoadLibraries  <- function() {
  library(ISLR)
  library(MASS)
  library(tidyverse)
  library(coefplot)
  print("The libraries have been loaded!")
}
