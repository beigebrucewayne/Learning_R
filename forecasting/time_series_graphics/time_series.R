library(tidyverse)
library(fpp2)

data  <- read_csv('~/Desktop/data.csv')

correct.dates <- data %>%
  mutate(dates = parse_date(data$day, '%m/%d/%y'))

# seasonal plots
ggseasonplot(correct.dates, year.labels=TRUE, year.labels.left=TRUE) +
  ylab('cpc') + ggtitle('Date vs CPC')

# works
correct.dates %>%
  ggplot(aes(correct.dates$dates, log(correct.dates$cpc))) + geom_point(mapping = aes(color=cpc)) + geom_smooth(method="lm")

# white noise
set.seed(30)
y  <- ts(rnorm(50))
autoplot(y) + ggtitle('White noise')
# white noise time series
ggAcf(y)
