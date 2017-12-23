# Workflow

## standardize

#### max - min
```r
max_data <- apply(data, 2, max)
min_data <- apply(data, 2, min)
data_scaled <- scale(data, center = min_data, scale = max_data - min_data)
```

#### z - score
```r
mean_data <- apply(data, 2, mean)
sd_data <- apply(data, 2, sd)
data_scaled <- as.data.frame(scale(data, center = mean_data, scale = sd_data))
```

## split test / train
```r
index <- sample(1:nrow(data), round(0.70 * nrow(data)))
train_data <- as.data.frame(data_scaled[index,])
test_data <- as.data.frame(data_scaled[-index,])
```

## construct formula
```r
n <- names(data)
f <- as.formula(paste("pred_value ~", paste(n[!n %in% "pred_value"], collapse = " + ")))
```

## generalization of nn

- early stoppinm of training
- retraining nn with different training data
- random sampling, stratified sampling
- train multiple nn & avg output

## ensemble prediction

1. data divided train / test
2. multiple models w/ different training sets & adjusting params
3. all models trained and errors in each model are tabulated
4. avg error is found for each row in test data and MSE is calculated for each model
5. MSE compared w/ MSE of avg
6. best model is chosen from comparison and used for prediction