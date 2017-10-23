library(car)
library(tidyverse)
library(fpp2)

data  <- read_csv('~/Desktop/tperf.csv')

# fix day column -> date
data  <- data %>%
  mutate(day = parse_date(data$day, '%m/%d/%y'))

# time series object
data.ts  <- ts(data, start = 1, end = 274, frequency = 1)

# graph
autoplot(data.ts[,c("Cost", "Clicks")]) +
  ylab("% Change") + xlab('Date')

# graph -> linear regression
data.ts %>%
  as.data.frame %>%
  ggplot(aes(x=Cost, y=Clicks)) +
  ylab("Clicks % Change") +
  xlab("Cost % Change") +
  geom_point() +
  geom_smooth(method="lm", se=FALSE)

model.ts  <- tslm(Clicks ~ Cost, data=data.ts) # 1 click, costs .54c
summary(model.ts)

data.ts %>%
  as.data.frame %>%
  GGally::ggpairs()
ggsave('tillamook_data.png')

data.no.date  <- data %>%
  select(-day.of.week)
head(data.no.date)

# time series object w/o day of week
data.ts.2  <- ts(data.no.date, start = 1, end = 274, frequency = 1)

data.ts.2 %>%
  as.data.frame %>%
  GGally::ggpairs()
ggsave('full_tillamook_data.png')


head(data.ts.2)

fit.till  <- tslm(clicks ~ cost + avg.cpm + avg.cpc + avg.pos + ctr + impr, data=data.ts.2)
summary(fit.till)
fit.till.no.cpm  <- tslm(clicks ~ cost + avg.cpc + avg.pos + ctr + impr, data=data.ts.2)
summary(fit.till.no.cpm)

# plotting predicted values
autoplot(data.ts.2[,'clicks'], series="Data") +
  forecast::autolayer(fitted(fit.till.no.cpm), series="Fitted") +
  guides(colour=guide_legend(title=""))


cbind(Data=data.ts.2[,'clicks'], Fitted=fitted(fit.till.no.cpm)) %>%
  as.data.frame %>%
  ggplot(aes(x=Data, y=Fitted)) +
  geom_point() +
  xlab('Predicted Values') +
  ylab('Actual Values') +
  geom_abline(intercept=0, slope=1)

checkresiduals(fit.till.no.cpm)

df  <- as.data.frame(data.ts.2)
df[,"Residuals"]  <- as.numeric(residuals(fit.till.no.cpm))
p1  <- ggplot(df, aes(x=cost, y=Residuals)) + geom_point()
# negative correlation
p2  <- ggplot(df, aes(x=avg.cpc, y=Residuals)) + geom_point()
p3  <- ggplot(df, aes(x=avg.pos, y=Residuals)) + geom_point()
p4  <- ggplot(df, aes(x=ctr, y=Residuals)) + geom_point()

vif(fit.till.no.cpm)

fit  <- tslm(clicks ~ day, data=data.ts.2)
cbind(Fitted=fitted(fit), Residuals=residuals(fit)) %>%
  as.data.frame %>%
  ggplot(aes(x=Fitted, y=Residuals)) + geom_point()
