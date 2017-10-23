library(tidyverse)
library(fpp2)

data  <- read_csv('~/Desktop/tperf.csv')
data.no.dw  <- data %>% select(-day.of.week)

data.no.dw  <- data.no.dw %>%
  mutate(day = parse_date(data.no.dw$day, '%m/%d/%y'),
         cost = cost / 1000000,
         avg.cpm = avg.cpm / 1000000,
         avg.cpc = avg.cpc / 1000000)

data.ts  <- ts(data.no.dw, start = 1, end = 274, frequency = 1)

# Differencing -> compute differences between consecutive observations

data.cpc.vec  <- as.vector(data.no.dw$avg.cpc)
Box.test(diff(data.cpc.vec), lag=10, type="Ljung-Box")

# random walk model

  # long periods of apparent trends up or down
  # sudden and unpredictable changes in direction

  # forecasts -> equal to last observation, as future movements are unpredictable, and are equally likely to be up or down
    # c -> average of changes between consecutive observations

# seasonal differencing

  # difference between an observation and corresponding obs from previous year 
  # forecasts -> equal to last observation from relevant season
