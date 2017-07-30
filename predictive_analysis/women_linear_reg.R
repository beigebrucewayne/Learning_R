require(graphics)
data(women)
lm_output  <- lm(women$height ~ women$weight)
summary(lm_output)
prediction  <- predict(lm_output)
error  <- women$height - prediction
plot(women$height, error)
