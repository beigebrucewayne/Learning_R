library(keras)

mnist  <- dataset_mnist()

x_train  <- mnist$train$x
y_train  <- mnist$train$y
x_test  <- mnist$test$x
y_test  <- mnist$test$y

# reshape
# convert 3-d arrays => matrices
# reshape width, height => 
# single dimension (28x28 image flattened) => length 784 vectors
x_train  <- array_reshape(x_train, c(nrow(x_train), 784))
x_test  <- array_reshape(x_test, c(nrow(x_test), 784))

# rescale
# convert grayscale ints :: rng(0, 255) =>
# float :: rng(0, 1)
x_train  <- x_train / 255
x_test <- x_test / 255

# one-hot encode
# y: vec<int> => binary class matrices
y_train  <- to_categorical(y_train, 10)
y_test  <- to_categorical(y_test, 10)

#' Defining The Model

model  <- keras_model_sequential()
model %>%
  layer_dense(units = 256, activation ='relu', input_shape = c(784)) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 10, activation = 'softmax')

summary(model)

#' Compiling Model

model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_rmsprop(),
  metrics = c('accuracy')
)

#' Training & Evaluation
history <- model %>% fit(
  x_train, y_train,
  epochs = 30, batch_size = 128,
  validation_split = 0.2
)

# plotting :: loss and accuracy metrics
plot(history)

# model performance :: test data
model %>% evaluate(x_test, y_test)

# predictions => new data
model %>% predict_classes(x_test)
