# resampling - drawing samples from training set and refitting model of interest on each sample to get further info on fitted model

### CROSS-VALIDATION


# test error rate - avg error from using statistical learning method to predict repsonse on new obs

# divide into two sets
    # training set
    # validation set (hold-out set)

# two drawbacks of validation approach
    # 1. validation estimate of test error rate can be highly variable, depending on which obs are in training data versus validation set
    # 2. validation set error rate may tend to overestimate the test error rate for model fit on entire data set

### LEAVE-ONE-OUT CROSS-VALIDAITON

# fit statistcal method repeatedly using n-1 observations

### K-FOLD CROSS VALIDATION

# randomly divide set of obs into K groups, or folds
