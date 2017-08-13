library(WDI)
# pull data
gdp <- WDI(country=c("US", "CA", "GB", "DE", "CN", "JP", "SG", "IL"), indicator=c("NY.GDP.PCAP.CD", "NY.GDP.MKTP.CD"),
           start=1960, end=2011)
# give it better names
names(gdp) <- c("iso2c", "Country", "Year", "PerCapGDP", "GDP")
head(gdp)
library(ggplot2)
library(scales)
library(useful)
# per capita GDP
ggplot(gdp, aes(Year, PerCapGDP, color=Country, linetype=Country)) + geom_line() + scale_y_continuous(label=dollar)
# absolute GDp
ggplot(gdp, aes(Year, GDP, color=Country, linetype=Country)) + geom_line() + scale_y_continuous(label=multiple_format(extra=dollar, multiple="M"))

# get US data
us <- gdp$PerCapGDP[gdp$Country == "United States"]
# conver to time series data
us <- ts(us, start=min(gdp$Year), end=max(gdp$Year))
us
# plot time series
plot(us, ylab="Per Capita GDP", xlab="Year")

# VAR
library(reshape2)
# cast to data.frame to wide format
gdpCast <- dcast(Year ~ Country,
  data=gdp[,c("Country", "Year", "PerCapGDP")],
  value.var="PerCapGDP")
head(gdpCast)
# convert to time series
gdpTS <- ts(data=gdpCast[,-1], start=min(gdpCast$Year), end=max(gdpCast$Year))
# build plot and legend using base graphics
plot(gdpTS, plot.type="single", col=1:8)
legend("topleft", legend=colnames(gdpTS), ncol=2, lty=1, col=1:8, cex=.9)
# get rid of Germany columns because of lack of data
gdpTS <- gdpTS[,which(colnames(gdpTS) != "Germany")]

# regressing with times series
# checking number of diffs
numDiffs <- ndiffs(gdpTS)
numDiffs # 1
gdpDiffed <- diff(gdpTS, differences=numDiffs)
plot(gdpDiffed, plot.type="single", col=1:7)
legend("bottomleft", legend=colnames(gdpDiffed), ncol=2, lty=1, col=1:7, cex=.9)

