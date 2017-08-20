# 3 types of classification - logistic regression, linear discriminant analysis and K-nearest neighbors

# whether individual willd efault on his/her credit card payment, on basis of annual income and monthly credit card balance


### LOGISTIC REGRESSION ###

# Y (RESPONE) - DEFAULT; binary -> yes, no
# Probability that y belongs to a given group
# Pr(default = Yes|balance); p(balance)

## LOGISTIC MODEL

# logistic function
  # p(X) = e^(bo+B1X) / 1 + e^(Bo+B1X)

# uses maximum likelihood

# logit function
  # log(p(X) / 1 - p(X))

# increasing X + 1 unit, increases the log oadds


### LINEAR DISCRIMINANT ANALYSIS ###

# two response classes -> model conditional distribution of response Y, given predictors X
    # use bayes' theorem to flip these estimates

# why use LDA
    # classes are well-separated, logistic regression parameter estimates are unstable
    # if n is small and distribution of predictors X is approx normal in each class, LDA is more stable

### BAYES THEOREM FOR CLASSIFICATION

# posterior probability - probability that obs belongs to kth class, given predictor value for obs

### LDA for p = 1

# µ = 1 / nk 𝐸xi
# ó^2 = 1 / n - k EE(xi - uk)^2

### LDA for p > 1


