library(fpp2)
library(tidyverse)

# average method ==> forecasts fo all future values are equal to the mean of historical data
meanf(y, h)
# y -> time series
# h -> forecast horizon


# naive method ==> all forecasts are simply value of last observation
naive(y, h)
rwf(y, h) # alternative


# seasonal naive method ==> each forecast equal to last observed value from same season of the year
snaive(y, h)


# drift method ==> forecasts to +/- over time, where amount of change set to avg change seen in historical data
rwf(y, h, drift=TRUE)


# examples
beer2  <- window(ausbeer, start=1992, end=c(2007, 4))

autoplot(beer2) +
  forecast::autolayer(meanf(beer2, h=11), PI=FALSE, series="Mean") +
  forecast::autolayer(naive(beer2, h=11), PI=FALSE, series="Naive") +
  forecast::autolayer(snaive(beer2, h=11), PI=FALSE, series="Seasonal naive") +
  ggtitle("Forecasts for quarterly beer production") +
  xlab("Year") + ylab("Megalitres") +
  guides(colour=guide_legend(title="Forecast"))

data  <- read_csv('~/Desktop/data.csv')
data  <- data %>%
  mutate(day = parse_date(data$day, '%m/%d/%y'))
head(data)
# time series obejct
cpc.ts  <- ts(data$cpc, start = 1, end = 282, frequency = 1)

autoplot(cpc.ts) +
  forecast::autolayer(meanf(cpc.ts, h=42), PI=FALSE, series="Mean") +
  forecast::autolayer(rwf(cpc.ts, h=42), PI=FALSE, series="Naive") +
  forecast::autolayer(rwf(cpc.ts, h=42), PI=FALSE, series="Drift") +
  ggtitle("Tillamook CPC") +
  xlab('Day') + ylab('Cpc') +
  guides(colour=guide_legend(title="Forecast"))


# calendar adjustments
cbind(Monthly = milk, DailyAverage = milk/monthdays(milk)) %>%
  autoplot(facet=TRUE) + xlab("Years") + ylab("Pounds") +
  ggtitle("Milk production per cow")

# mathematical transformations
(lambda  <- BoxCox.lambda(elec)) # selects lambda for you
autoplot(BoxCox(ele, lambda))


# fitted values ==> forecast using all previous observations
# residuals ==> what's left over after fitting a model
    # residuals -> uncorrelated, if not should be used for computing
    # residuals -> zero mean
    # residuals -> constant variance
    # residuals -> normally distributed


res  <- residuals(naive(cpc.ts))
autoplot(res) + xlab('Day') + ylab('Cpc') + ggtitle('Tillamook CPC - Residuals from Naive Method')

gghistogram(res) + ggtitle("Histogram of residuals")

ggAcf(res) + ggtitle("ACF of residuals")


# lag = h, fitdf = K
Box.test(res, lag=10, fitdf=0) # Box-Pierce
Box.test(res, lag=10, fitdf=0, type="Lj") # Box-Ljung

checkresiduals(naive(cpc.ts))


# evaluating forecast accuracy

fit1  <- meanf(cpc.ts, h=10)
fit2  <- rwf(cpc.ts, h=10)
fit3  <- snaive(cpc.ts, h=10)

autoplot(cpc.ts) +
  forecast::autolayer(fit1, series="Mean", PI=FALSE) +
  forecast::autolayer(fit2, series="Naive", PI=FALSE) +
  forecast::autolayer(fit3, series="Seasonal naive", PI=FALSE) +
  guides(colour=guide_legend(title="Forecast"))


autoplot(naive(cpc.ts))
holt(cpc.ts)
autoplot(holt(cpc.ts))
