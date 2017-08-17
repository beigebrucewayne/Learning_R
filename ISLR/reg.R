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
