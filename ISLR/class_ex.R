library(ISLR)
head(Smarket)
dim(Smarket)
summary(Smarket)
cor(Smarket [,-9]) # remove Direction column =/= numeric

# plot year + vol relationship
library(tidyverse)
library(ggthemes)
year.vol  <- Smarket %>%
  ggplot(aes(Year, Volume)) +
  geom_point() +
  theme_hc(bgcolor="darkunica")
# print graph
year.vol
# logistic regression to predict direction
# family = binomail, suggests logistic regression
glm.fit  <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data=Smarket, family=binomial)
summary(glm.fit)
coef(glm.fit)
library(coefplot)
coefplot(glm.fit)
summary(glm.fit)$coef
# using predict() - prob that market will go up
glm.probs  <- predict(glm.fit, type="response")
glm.probs[1:10]
# attach columns, so can skip df$col syntax
attach(Smarket)
# see how R coded dummy variable
contrasts(Direction)
# must create class labels for Up or Down
# create vector of class predictions, whether prob > 0.5
glm.pred  <- rep("Down", 1250) # vector of 1250 down elements
glm.pred[glm.probs > .5] = "Up" # transforms to "Up" all elements, pred value > 0.5
# create confusion matrix
table(glm.pred, Direction)
correct.pred  <- (507+145)/1250
mean(glm.pred==Direction)
# train data set
train  <- (Year < 2005)
Smarket.2005  <- Smarket[!train,]
dim(Smarket.2005)
Direction.2005  <- Direction[!train]
# test data logistic model
glm.fit2  <- glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data=Smarket, family=binomial, subset=train)
glm.probs2  <- predict(glm.fit2, Smarket.2005, type="response")
glm.pred2  <- rep("Down", 252)
glm.pred2[glm.probs2 > .5] = "Up"
table(glm.pred2, Direction.2005)
# test error rate
mean(glm.pred2!=Direction)
# remove lackluster variables
glm.fit3  <- glm(Direction ~ Lag1 + Lag2, data=Smarket, family=binomial, subset=train)
glm.probs  <- predict(glm.fit3, Smarket.2005, type="response")
glm.pred3  <- rep("Down", 252)
glm.pred3[glm.probs > .5] = "Up"
table(glm.pred3, Direction.2005)
mean(glm.pred3==Direction.2005)
# predictions for given values
predict(glm.fit3, newdata=data.frame(Lag1=c(1.2, 1.5), Lag2=c(1.1, -0.8)), type="response")


### LINEAR DISCRIMINANT ANALYSIS


library(MASS) # contains lda() function
lda.fit  <- lda(Direction ~ Lag1 + Lag2, data=Smarket, subset=train)
lda.fit
library(ggplot2)
plot(lda.fit)
lda.pred  <- predict(lda.fit, Smarket.2005)
lda.class  <- lda.pred$class
table(lda.class, Direction.2005)
mean(lda.class==Direction.2005)
# 50% threshold
sum(lda.pred$posterior[,1] >= .5)
sum(lda.pred$posterior[,1] < .5)
lda.pred$posterior[1:20,1]
lda.class[1:20]


### K-NEAREST NEIGHBORS


# 4 inputs
    # 1. Matrix containing predictors associated with training data
    # 2. Matrix containing predictors associated with data for which we wish to make predictions
    # 3. Vector containing class labels for training obs
    # 4. Value for K, # of nearest neighbors to be used by classifier

library(class)
library(ISLR)
attach(Smarket)
train.X  <- cbind(Lag1, Lag2)[train,]
test.X  <- cbind(Lag2, Lag2)[!train,]
train.Direction  <- Direction[train]
head(train.Direction)
set.seed(1)
knn.pred  <- knn(train.X, test.X, train.Direction, k=1)
table(knn.pred, Direction.2005)
mean(knn.pred==Direction.2005)

# Caravan data - response: whether they purchase insurance or not
library(ISLR)
dim(Caravan)
head(Caravan)
names(Caravan)
attach(Caravan)
summary(Caravan$Purchase)
out  <- 348/5822

# standardize variables to a mean of zero, std dev = 1
# scale() - mean = zero, std dev = 1
# column 86 = qualitative column "Purchase"
standardized.X  <- scale(Caravan[,-86])
var(Caravan[,1])
var(Caravan[,2])
var(standardized.X[,1])
var(standardized.X[,2])
# test set -> first 1000 obs
# training set -> remaining obs
# fit K=1, then evaluate performance
test  <- 1:1000
train.X  <- standardized.X[-test,]
test.X  <- standardized.X[test,]
train.Y  <- Caravan$Purchase[-test]
test.Y  <- Caravan$Purchase[test]
set.seed(1)
knn.pred  <- knn(train.X, test.X, train.Y, k=1)
mean(test.Y!=knn.pred)
mean(test.Y!="No")
table(knn.pred, test.Y)
# KNN, with K=3
knn.pred  <- knn(train.X, test.X, train.Y, k=3)
table(knn.pred, test.Y)
