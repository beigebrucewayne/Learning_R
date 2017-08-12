# how do we judge quality of a model?

##### RESIDUALS #####
# difference between actual response and fitted values

# read in data
housing <- read.table("http://www.jaredlander.com/data/housing.csv", sep=",", header=TRUE, stringsAsFactors = FALSE)
head(housing)
# rename dataset to better names
names(housing) <- c("Neighborhood", "Class", "Units", "YearBuilt", "SqFt", "Income", "IncomePerSqFt", "Expense", "ExpensePerSqFt", "NetIncome", "Value", "ValuePerSqFt", "Boro")
head(housing)
# eliminate outliers
housing <- housing[housing$Units < 1000,]
# fit model
house1 <- lm(ValuePerSqFt ~ Units + SqFt + Boro, data=housing)
summary(house1)
# visualize model
library(coefplot)
coefplot(house1)

# 3 important plots for residuals
  # 1. fitted values against residuals
  # 2. histogram of residuals
  # 3. Q-Q plots

library(ggplot2)
# what fortified lm model looks like
head(fortify(house1))
# save plot to object
h1 <- ggplot(aes(x=.fitted, y=.resid), data=house1) +
  geom_point() +
  geom_hline(yintercept=0) +
  geom_smooth(se=FALSE) +
  labs(x="Fitted Values", y="Residuals")
h1
h1 + geom_point(aes(color=Boro))

# Q-Q plot
# if model is good residuals should fall along theoretical quantiles of normal distribution
ggplot(house1, aes(sample=.stdresid)) + stat_qq() + geom_abline()

# histogram of residuals
ggplot(house1, aes(x=.resid)) + geom_histogram()

# creating multiple models for comparison

house2 <- lm(ValuePerSqFt ~ Units * SqFt + Boro, data=housing)
house3 <- lm(ValuePerSqFt ~ Units + SqFt * Boro + Class, data=housing)
house4 <- lm(ValuePerSqFt ~ Units + SqFt * Boro + SqFt * Class, data=housing)
house5 <- lm(ValuePerSqFt ~ Boro + Class, data=housing)

# visualize multiple models using multiplot
multiplot(house1, house2, house3, house4, house5)
# using ANOVA to look at RSS -> lower better
anova(house1, house2, house3, house4, house5)
# Akaike Information Criterion (AIC)
AIC(house1, house2, house3, house4, house5)
# Bayes Information Criterion (BIC)
BIC(house1, house2, house3, house4, house5)


# anova -> glm models -> deviance of model
# every added variable -> deviance should drop by 2

# create binary variable based on whether Value ValuePerSqFt is > 150
housing$HighValue <- housing$ValuePerSqFt >= 150
# fit a few models
high1 <- glm(HighValue ~ Units + SqFt + Boro, data=housing, family=binomial(link="logit"))
high2 <- glm(HighValue ~ Units * SqFt + Boro, data=housing, family=binomial(link="logit"))
high3 <- glm(HighValue ~ Units + SqFt * Boro + Class, data=housing, family=binomial(link="logit"))             
high4 <- glm(HighValue ~ Units + SqFt * Boro + SqFt * Class, data=housing, family=binomial(link="logit"))
high5 <- glm(HighValue ~ Boro + Class, data=housing, family=binomial(link="logit"))
# test modesl using anova (deviance) AIC and BIC
anova(high1, high2, high3, high4, high5)
AIC(high1, high2, high3, high4, high5)
BIC(high1, high2, high3, high4, high5)


##### CROSS VALIDATION #####

library(boot)
# refit house1 using glm instead of lm
houseG1 <- glm(ValuePerSqFt ~ Units + SqFt + Boro, data=housing, family=gaussian(link="identity"))
# same results as lm
identical(coef(house1), coef(houseG1))
# fun cross-validation with 5 folds
houseCV1 <- cv.glm(housing, houseG1, K=5)
houseCV1$delta
# refits models using glm
houseG2 <- glm(ValuePerSqFt ~ Units * SqFt + Boro, data=housing)
houseG3 <- glm(ValuePerSqFt ~ Units * SqFt * Boro + Class, data=housing)
houseG4 <- glm(ValuePerSqFt ~ Units + SqFt * Boro + SqFt * Class, data=housing)
houseG5 <- glm(ValuePerSqFt ~ Boro + Class, data=housing)
# run cross validation for models
houseCV2 <- cv.glm(housing, houseG2, K=5)
houseCV3 <- cv.glm(housing, houseG3, K=5)
houseCV4 <- cv.glm(housing, houseG4, K=5)
houseCV5 <- cv.glm(housing, houseG5, K=5)
# check error results
# build data.frame from results
cvResults <- as.data.frame(rbind(houseCV1$delta, houseCV2$delta, houseCV3$delta, houseCV4$delata, houseCV5$delta))
# reanme to clean results
names(cvResults) <- c("Error", "Adjusted.Error")
# add model name
cvResults$Model <- sprintf("houseG%s", 1:5)
# check results
cvResults
# visualize the results
cvANOVA <- anova(houseG1, houseG2, houseG3, houseG4, houseG5)
cvResults$ANOVA <- cvANOVA$`Resid. Dev`
# meausre with AIC
cvResults$AIC <- AIC(houseG1, houseG2, houseG3, houseG4, houseG5)


##### GENERALIZED CROSS VALIDATION FRAMEWORK #####

cv.work  <- function(fun, k=5, data, cost=function(y,yhat) mean((y-yhat)^2), response="y", ...)
{
  # generate folds
  folds  <- data.frame(Fold=sample(rep(x=1:k, length.out=nrow(data))), Row=1:nrow(data))
  # start error at 0
  error  <- 0
  # loop each fold
  # for each fold:
  # fit model on training data, predict test data, compute error and acccumulate it
  for(f in 1:max(folds$Fold)) {
  # rows are in test set
  theRows  <- folds$Row[folds$Fold == f]
  # call fun on data[-theRows,]
  # predict on data[theRows,]
  mod  <- fun(data=data[-theRows,], ...)
  pred <- predict(mod, data[theRows,])
  # add new error weighted by number of rows in fold
  error  <- error + cost(data[theRows, response], pred) * (length(theRows)/nrow(data))
  }
  return(error)
}

# example use
cv1  <- cv.work(fun=lm, k=5, data=housing, response="ValuePerSqFt", formula=ValuePerSqFt ~ Units + SqFt + Boro)


##### BOOTSTRAP #####

library(plyr)
baseball  <- baseball[baseball$year >= 1990,]
head(baseball)
# build function for calculating batting average
bat.avg  <- function(data, indices=1:NROW(data), hits="h", at.bats="ab")
{
  sum(data[indices, hits], na.rm=TRUE) / sum(data[indices, at.bats], na.rm=TRUE)
}
bat.avg(baseball)

# bootstrap it
# call bat.avg -> 1,200 times
# pass indices to the function
library(boot)
avgBoot  <- boot(data=baseball, statistic=bat.avg, R=1200, stype="i")
# print orign measure and estimates of bias and strd. error
avgBoot
#print confidence interval
boot.ci(avgBoot, conf=.95, type="norm")
# graphing the distribution
library(ggplot2)
ggplot() +
  geom_histogram(aes(x=avgBoot$t), fill="blue", color="grey") +
  geom_vline(xintercept=avgBoot$to + c(-1, 1)*2*sqrt(var(avgBoot$t)), linetype=2)
