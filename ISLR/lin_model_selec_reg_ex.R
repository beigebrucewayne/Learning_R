####################
# Best Subset Selection
####################


library(ISLR)
library(tidyverse)
names(Hitters)
dim(Hitters)
# total NA values in data
sum(is.na(Hitters))

# convert data to tibble
hitters  <- as.tibble(Hitters)
head(hitters)

# remove rows with any missing values
hitters  <- na.omit(Hitters)
sum(is.na(hitters))

# leaps -> for regsubsets()
library(leaps)
regfit.full  <- regsubsets(Salary ~., Hitters)
summary(regfit.full)

regfit.full2  <- regsubsets(Salary~., data = Hitters, nvmax = 19)
reg.summary  <- summary(regfit.full2)
names(reg.summary)
reg.summary$rsq

par(mfrow = c(2, 2))
plot(reg.summary$rss, xlab = "Number of Variables", ylab = "RSS")
plot(reg.summary$adjr2, xlab = "Number of Variables", ylab = "Adjusted RSq") 

# use which.max() + points() -> indicate model with best RSq
which.max(reg.summary$adjr2)
points(11, reg.summary$adjr2[11], col = "red", cex = 2, pch = 20)

plot(reg.summary$cp, xlab = "Number of Variables", ylab = "Cp")
which.min(reg.summary$cp)
points(10, reg.summary$cp[10], col = "red", cex = 2, pch = 20)
which.min(reg.summary$bic)
plot(reg.summary$bic, xlab = "Number of Variables", ylab = "BIC")
points(6, reg.summary$bic[6], col = "red", cex = 2, pch = 20)

# use built in regsubsets() plot
plot(regfit.full2, scale = "r2")
plot(regfit.full2, scale = "adjr2")
plot(regfit.full2, scale = "Cp")
plot(regfit.full2, scale = "bic")

# see coefs for 6 var model with lowest BIC
coef(regfit.full2, 6)


####################
# Forward / Backward Stepwise Selection
####################

# specify method for forward or backward selection
regit.fwd  <- regsubsets(Salary~., data = hitters, nvmax = 19, method = "forward")
summary(regit.fwd)
regit.bwd  <- regsubsets(Salary~., data = hitters, nvmax = 19, method = "backward")
summary(regit.bwd)

coef(regfit.full2, 7)
coef(regit.bwd, 7)
coef(regit.fwd, 7)


####################
# Choose Model -> Validation % C-V
####################

# use ONLY training data

# split data for train/test
# set seed for reproducability
set.seed(1)
train  <- sample(c(TRUE, FALSE), nrow(Hitters), rep = TRUE)
test  <- (!train)
regfit.best  <- regsubsets(Salary ~., data = hitters[train, ], nvmax = 19)
# compute validation set error for best model of each model size
# model matrix form test data
test.mat  <- model.matrix(Salary ~., data=hitters[test, ])
val.errors  <- rep(NA, 19)
for(i in 1:19) {
  coefi  <- coef(regfit.best, id = i)
  pred  <- test.mat[, names(coefi)]%*%coefi
  val.errors[i]  <- mean((hitters$Salary[test] - pred)^2)
}


####################
# Ridge Regression
####################
