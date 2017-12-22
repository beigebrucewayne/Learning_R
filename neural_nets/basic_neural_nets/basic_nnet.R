library(nnet)
library(NeuralNetTools)
library(readr)


raw_data  <- read_csv("https://raw.githubusercontent.com/PacktPublishing/Neural-Networks-with-R/master/Chapter01/RestaurantTips.csv")

## Classification w/ 3 inputs + 1 categorical

mydata  <- raw_data

names(mydata)

## train model

model  <- nnet(CustomerWillTip ~ Service + Ambience + Food,
               data = mydata,
               size = 5,
               rang = 0.1,
               decay = 5e-2,
               maxit = 5000)

print(model)
plotnet(model)
garson(model)
olden(model)
lekprofile(model)
