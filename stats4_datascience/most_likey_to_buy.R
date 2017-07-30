# logistic regression
  # dependent var - binary ( 0 or 1 )
  # uses maximum likelihood via grid search

# maxmimum likelihood - estimation technique ( opposed to OLS ) find estimators that maximize likelihood function observing sample given

# logistic regression models the 'logit', rather than dependent var
  # logit = log of event/( 1 - the event )

# output of logistisic regression is probability from 0 -> 100%
  # output of linear is estimated (predicted) value to fit depend var

# logistic regression coefficients effect is e ^ ( coeff )
  # example
    # education var, coeff = .2
      # e^( .200 ) = 1.225
      # thus, each year of added education increases probability by 22.5%
        # suggests targeting highest educated families

# output of logit regression - is confusion matrix
  # accuracy = correct predicted / total obs

# use z-score to check for outliers
  # obs - mean / std dev
    # run for each obs, then if obs > 3, = 1, 0 if obs , 3 ( new column )

# collinearity - measure of how variables correlate with each other
  # two independent vars more correlated than either with respect to dependent var
    # p(X1, X2) > p(Y,X1) || p(Y,X2)...where p = correlation

# VIF testing = 1 / ( 1 - R^2 )
  # if VIF > 10

# logit regression uses wald test, which is t-test ^ 2
  # p-value still needs to be < 0.05

# scoring database
  # probability = 1 / ( 1 + e^( -Z) ), where Z = a + BXi
    # e = 2.71828

# market basket - what % of items are purchased together
# affinity analysis - calculates % of time combos of products are purchased together

# 3 uses of data
  # descriptive - about the past
  # predictive - uses statistical analysis to calculate change on output var given change in input var
  # prescriptive - system to optimize some metric


# logistic regression

# formula to estimate probability from logistic regression
  # P(i) = 1 / 1 + e^( - Z), where Z = a + BXi
