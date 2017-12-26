# Optimization & Machine Learning

### mulitcollinearity

Correlation between explanatory variables. Drop variable, or ridge regression / lasso regression.

### Evaluating Regression Models

`bootstrapping`

1. build several models
2. collect sample statistics
    - mean
    - std dev
    - max
    - min
3. evaluate results and pick model most effective for objectives

##### Bootstrap Evaluators

- R2
- MSE :: our objective is to minimize MSE
- SE :: as close to 0 as possible

## Logistic Regression

* `logistic function` :: f(x) = ( 1 / (1 + e^(-x)) )

* threshold depends on what is being optimized: accuracy, sensitivity or specificity
    - accuracy (identify true positives) :: true pos + true neg / pos + neg
    - sensitivity (identify true negatives) / recall :: true pos / true pos + false neg
    - specificity (identify both) :: true neg / true neg + false pos

### ROC Curve (Receiver Operating Characteristic)

Ability of binary classifier to accurately detect true positives and simultaneously check how innacurate it is by displaying false positive rate.
