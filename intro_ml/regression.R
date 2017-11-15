head(mtcars)

plot(y = mtcars$mpg, x = mtcars$disp, xlab = "Engine Size (cubic inches)", ylab = "Fuel Efficiency (Miles Per Gallon)")

model  <- lm(mtcars$mpg ~ mtcars$disp)

coef(model)

split.size  <- 0.8
sample.size  <- floor(split.size * nrow(mtcars))
set.seed(123)

train_indices  <- sample(seq_len(nrow(mtcars)), size = sample.size)

train  <- mtcars[train_indices, ]
test  <- mtcars[-train_indices, ]

# build out
model2  <- lm(mpg ~ disp, data = train)

new.data  <- data.frame(disp = test$disp)

test$output  <- predict(model2, new.data)

sqrt(sum(test$mpg - test$output)^2/nrow(test))
