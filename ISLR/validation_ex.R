# Validation Set Approach


library(ISLR)
set.seed(1)
train  <- sample(392, 196)
# use subset command to get only values from train set
lm.fit  <- lm(mpg ~ horsepower, data=Auto, subset=train)
# use predict() - estimate response for all 392 obs
# use mean() - to calculate MSE of 196 obs in validation set
attach(Auto)
mse  <- mean((mpg-predict(lm.fit, Auto))[-train]^2)
# use poly() - to estimate polynomial and cubric regressions
lm.fit2  <- lm(mpg ~ poly(horsepower, 2), data=Auto, subset=train)
mse2  <- mean((mpg-predict(lm.fit2, Auto))[-train]^2)
lm.fit3  <- lm(mpg ~ poly(horsepower, 3), data=Auto, subset=train)
mse3  <- mean((mpg-predict(lm.fit3, Auto))[-train]^2)


# Leave-One-Out Cross-Validation


library(boot)
library(ISLR)
glm.fit  <- glm(mpg ~ horsepower, data=Auto)
cv.err  <- cv.glm(Auto, glm.fit)
cv.err$delta
# for looch for polynomials
cv.error  <- rep(0,5)
for (i in 1:5) {
  glm.fit  <- glm(mpg ~ poly(horsepower, i), data=Auto)
  cv.error[i]  <- cv.glm(Auto, glm.fit)$delta[1]
}
cv.error


# K-Fold Cross Validation


set.seed(17)
cv.error.10  <- rep(0,10)
for (i in 1:10) {
  glm.fit  <- glm(mpg ~ poly(horsepower, i), data=Auto)
  cv.error.10[i]  <- cv.glm(Auto, glm.fit, K=10)$delta[1]
}
cv.error.10


# The Bootstrap


# estimating accuracy of a statistic of interest
  # 1. function to compute statistic of interst
  # 2. use boot() to repeatedly sample obs from data with replacement
library(ISLR)
alpha.fn  <- function(data, index) {
  X  <- data$X[index]
  Y  <- data$Y[index]
  return((var(Y) - cov(X, Y))/(var(X) + var(Y) - 2*cov(X,Y)))
}

# estimate (alpha) for all 100 obs
alpha.fn(Portfolio, 1:100)
# using sample() - randomly select 100 obs with replacement
# equivalent to new bootstrap data set, and recomputing alpha based on new data
set.seed(1)
alpha.fn(Portfolio, sample(100,100,replace=T))
# bootsrap is implementing this techinque many times
library(boot)
boot(Portfolio, alpha.fn, R=1000)

# estimating accuracy of linear regression model
boot.fn  <- function(data, index) {
  return(coef(lm(mpg ~ horsepower, data=data, subset=index)))
}
boot.fn(Auto, 1:392)
set.seed(1)
boot.fn(Auto, sample(392, 392, replace=T))
boot.fn(Auto, sample(392, 392, replace=T))
# use boot() - compute SE of 1000 bootstrap estimates
boot(Auto, boot.fn, 1000)
summary(lm(mpg ~ horsepower, data=Auto))$coef
boot.fn  <- function(data, index) {
  coef(lm(mpg ~ horsepower + I(horsepower^2), data=data, subset=index))
}
set.seed(1)
boot(Auto, boot.fn, 1000)
summary(lm(mpg ~ horsepower + I(horsepower^2), data=Auto))$coef
