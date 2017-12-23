library(h2o)

c1 <- h2o.init(max_mem_size = "2G",
               nthreads = 2,
               ip = "localhost",
               port = 54321)

data(iris)
summary(iris)

iris_d1 <- h2o.deeplearning(1:4, 5,
                            as.h2o(iris), hidden=c(5, 5),
                            export_weights_and_biases = T)
plot(iris_d1)
h2o.confusionMatrix(iris_d1)
h2o.hit_ratio_table(iris_d1)
h2o.r2(iris_d1)

h2o.weights(iris_d1, matrix_id = 1)
h2o.weights(iris_d1, matrix_id = 2)
h2o.weights(iris_d1, matrix_id = 3)
h2o.biases(iris_d1, vector_id = 1)
h2o.biases(iris_d1, vector_id = 2)
h2o.biases(iris_d1, vector_id = 3)

# plot weights connecting `Sepal.Length` to first hidden neurons
plot(as.data.frame(h2o.weights(iris_d1, matrix_id = 1))[,1])

pairs(iris[1:4], main = "Scatterplot matrices of Iris Data", pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])

m=iris.lm <- h2o.glm(x = 2:5, y = 1, training_frame = as.h2o(iris))
h2o.r2(m)

# anomaly model :: autoencoders
anomaly_model <- h2o.deeplearning(1:4,
                                  training_frame = as.h2o(iris),
                                  activation = "Tanh",
                                  autoencoder = TRUE,
                                  hidden = c(50, 20, 50),
                                  sparse = TRUE,
                                  l1 = 1e-4,
                                  epochs = 100)