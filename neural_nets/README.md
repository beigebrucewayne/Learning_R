# Neural Net & Deep Learning w/ R

## DNN Settings

* Small number of neurons :: high error, pred factors too complex
* Large number of neurons :: overfit training data and not generalize  
* # of neurons in each hidden layer :: between size of input and output layer, potentially mean  
* # of neurons in each hidden layer :: not twice size of input neurons  

## z-score norm

Xscaled = x - mean / sd
```r
mean_data <- apply(data, 2, mean)
sd_data <- apply(data, 2, sd)
data_scaled <- as.data.frame(scale(data, center = mean_data, scale = sd_data))
```

## min-max scaling

```r
max_data <- apply(data, 2, max)
min_data <- apply(data, 2, min)
data_scaled <- scale(data, center = min_data, scale = max_data - min_data)
```

package | taxonomy of nn | underlying lang
-- | -- | --
MXNet | feed-forward, CNN | c / c++ / cuda
darch | RMB, DBN, | c / c++
deepnet | feed-forward, RBM, DBN, autoencoders | r
h20 | feed-forward network, autoencoderes | java
nnet and neuralnet | feed-forward | r
keras | variety of dnn | python / keras.io
tensorflow | variety of dnn | c++ / python / google

## Turn Cat Vars -> Numeric

College$Private :: "Yes", "No", "Yes"  
Private :: as.numeric(College$Private) - 1  
Private :: 1, 0, 1  
