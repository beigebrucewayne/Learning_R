### DECIDING IMPORTANT VARIABLES ### 


# quality of a model
  # Mallow's C
  # (AIC) - akaike information criterion
  # (BIC) - bayes information criterion
  # Adj. R^2 - adjusted r-squared

# total models per column = 2^p

# 3 ways to handle this

# (1.) - Foward selection
      # fit null model - intercept w/ no predictors
      # fit (p) simple linear regressions to null add variable with lowest RSS
# (2.) - Backward selection
      # start with all variables in the model
      # remove variable with the largest p-value
      # cont...until some stopping rule -> rule: remaining vars > some p-value threshold
# (3.) - Mixed selection
      # no variables in model, then add var that provides best fit
      # continue to add one-by-one
      # if var rises above certain p-value threshold (remove)


### MODEL FIT ###


# two main numerical measures
# R^2 - correlation of response and variable -> Cor(Y,Yhat)^2
# RSS - residual squared error - avg. amount given point deviates from model


### QUALITATIVE PREDICTORS ###

# predictors with only two levels
# xi = {1 if ith person = female, 0 if ith person = male
# xi = {1 if female, -1 if male

# predictors with more than two levels
# xi = {1 if Asian, 0 if not Asian
# xi2 = {1 if Caucasian, 0 if not Caucasian


### EXTENSIONS OF LINEAR MODEL ###

# Additive - effect of changes in predictor Xj on response Y is independent of values of other predictors
# Linear - changes in Y due to a one-unit change in Xj is constant, regardless of value of Xj

# removing additive assumption
  # use interaction variable (some_var * related_var)

# hierarchical principle - keep main effect if used in interaction term, even if not statistically significant


### POLYNOMIAL REGRESSION ###

# using some_variable^2

# mpg = Bo + B1 * horsepower + B2 * horsepower^2 + e


### POTENTIAL PROBLEMS ###

# 1. Non-linearity of the response-predictor relationship
# 2. Correlation of error terms
# 3. Non-constant variance of error terms
# 4. Outliers
# 5. High-leverage points
# 6. Collinearity


### NON-LINEARITY OF DATA ###

# residual plots - ei = y - y(bar) versus xi, multiple reg = residuals vs predicted
  # should show no pattern

### CORRELATION OF ERROR TERMS ###

# often occur in time series data
# plot residuals as function of time

### NON CONSTANT VARIANCE OF ERROR TERMS ###

# error terms have constant variance; Var(ei) = o^2
# heteroscedasticity
# transform using log(Y) or sqrt(Y)

### HIGH-LEVERAGE POINTS ###

# leverage statistic
  # h = (1/n) + ((xi-x(bar)^2/E(xi-x(bar))^2)
  # if value > (p+1)/n; high leverage is likely

### COLLINEARITY ###

# two, or more, predictor variables are highly correlated
# look at correlation matrix of the predictor variables
# VIF test - variance inflation factor
# VIF(bj) = 1 / (1 - R^2(xj|X-j))

# drop one of problematic variabels


### KNN REGRESSION ### - non-parametric

# f(hat)(xo) = 1 / K (Eyi)

# optimal fit depends on bias-variance tradeoff
# curse of dimensionality - given observation has no nearby neighbors


# *** parametric outperforms non-parametric if true form of f is of a parametric form
