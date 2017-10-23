# campaign | channel | return | spend

library(ggplot2)
library(scales)
library(dplyr)
library(gridExtra)

fileName  <- 'oneChannelData.csv'
myData  <- read.csv(file = fileName, header = TRUE, sep = ',')

# plot data
channelName  <- as.character(myData$Channel[1])
maxX = 1.05 * max(myData$Spend)
maxY = 1.05 * max(myData$Return)

myPlotDataDF  <- data.frame(Return = myData$Return, Spend = myData$Spend)

simpleScatterPlot  <- ggplot(myPlotDataDF, aes(x=Spend, y=Return)) +
  geom_point(color="black") +
  theme(panel.background = element_rect(fill='grey85'),
        panel.grid.major = element_line(colour='white')) +
  coord_cartesian(ylim = c(0, maxY), xlim = c(0, maxX)) +
  scale_x_continuous(labels = dollar) +
  scale_y_continuous(labels = comma) +
  ggtitle(paste(channelName))

simpleScatterPlot

# linear model =/= assumes infinite growth


# need model with diminishign marginal returns

# ADBUDG model

    # return = B + (A - B) * ( Spend(^c) / D + Spend(^c))

    # A -> maximum amount of return possible for campaign given long term investment
    # B -> minimum amount of return "
    # C -> controls the shape of the curve
    # D -> represents the initial market share or market saturation effects

# nlminb()

    # objective -> function to be minimized
    # start -> initial values for parameters to be optimized
    # lower -> lower bound for constrained parameter optimization
    # upper -> upper bound for constrained parameter optimization
    # control -> additional control parameters

# Function: returns total observed error based on ADBUDG model
Ufun  <- function(x, Spend, Return) {
  predictedReturn  <- x[2] + (x[1] - x[2]) * ((Spend^x[3]) / (x[4] + (Spend^x[3])))
  errorSq  <- (predictedReturn - Return)^2
  sumSqError  <- sum(errorSq)
  return(sumSqError)
}

startValVec = c(25000,100,1.5,100000)
minValVec = c(0,0,1.01,0)
maxValVec = c(500000, 500000, 2, 10000000)

optim.params  <- nlminb(objective=Ufun, start=startValVec,
                       lower=minValVec, upper=maxValVec,
                       control=list(iter.max=100000, eval.max=2000),
                       Spend=myData$Spend,
                       Return=myData$Return)
