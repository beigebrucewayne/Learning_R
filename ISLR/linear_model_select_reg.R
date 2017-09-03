# 3 Classes of Methods for extending least squared

  # Subset Selection - identify subset of P that will correlate to response...fit model using OLS on reduced set of vars
  # Shrinkage - inlcude all P, estimated coeffs are shrunked towards zero, reduces variance 
  # Dimension Reduction - project P predictors into M-dimensional subspace, M < p


####################
# Subset Selection
####################

# Best Subset Selection

# fit separate OLS for each combo of P predictors

# Stepwise Selection

# Forward
# fit zero P, then add 1, choose best, iterate

# Backward
# all P, minus 1, choose best, iterate


####################
# Choosing Optimal Model
####################

# all P will result in lowest RSS and highest R^2 (training data)

# 2 ways to get best model with respect to test error
  # indirectly estimate test error by making adjustment to training error accounting for bias due to overfitting
      # AIC, BIC, Cp
  # directly esimate test error, use either validation set or cross-validation approach
      # Validation, Cross Validation


####################
# Shrinkage 
####################

# 2 best known techniques for shrinking regression coefficients towards zero
    # ridge regression and the lasso

# Ridge regression
  # includes shrinkage penalty as lambda -> infinity
  # final model includes all P

# Lasso
  # performs variable selection, also uses shrinkage penalty
  # as lambda -> infinity, some P = 0

# Principal Component Analysis
  # dimensioon reduction technique for regression

# High Dimensions, p > n (more vars than obs)
  # when p > n, linear regression is too flexible (overfits)
