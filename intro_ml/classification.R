head(mtcars)

plot(x = mtcars$mpg, y = mtcars$am, xlab = "Fuel Efficiency (Miles Per Gallon)", ylab = "Vehicle Transmission Type (0 = Automatic, 1 = Manual)")

library(caTools)

label_train  <- train[,9]
data_train  <- train[, -9]

model  <- LogitBoost(data_train, label_train)

data.test  <- test

lab  <- predict(model, data.test, type = "raw")

data.frame(row.names(test), test$mpg, test$am, lab)
