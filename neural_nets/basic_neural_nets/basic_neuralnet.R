library(neuralnet)
library(tidyverse)

data <- read_csv("https://raw.githubusercontent.com/PacktPublishing/Neural-Networks-with-R/master/Chapter01/Squares.csv")

# train model based on output from input
model <- neuralnet(formula = Output ~ Input,
                   data = data,
                   hidden = 10,
                   threshold = 0.01)

print(model)

# plot and see layers
plot(model)

# check data - actual :: predicted
final_output <- cbind(data$Input, data$Output,
                      as.data.frame(model$net.result))
colnames(final_output) <- c("Input", "Expected Output",
                            "Neural Net Output")
print(final_output)
