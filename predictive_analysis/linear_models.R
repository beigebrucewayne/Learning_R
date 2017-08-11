# basic example
data(father.son, package='UsingR')
library(ggplot2)
head(father.son)

# scatter plot w/ regression line
ggplot(father.son, aes(x=fheight, y=sheight)) + geom_point() + geom_smooth(method="lm") + labs(x="Fathers", y="Sons")

# actual regression
heightsLM  <- lm(sheight ~ fheight, data=father.son)
heightsLM
# full report on the model
summary(heightsLM)


##### ANOVA ALTERNATIVE

data(tips, package="reshape2")
head(tips)
tipsAnova  <- aov(tip ~ day - 1, data=tips) # -1 , indicates intercept should not be included in the model
tipsLM  <- lm(tip ~ day - 1, data=tips)
summary(tipsAnova)
summary(tipsLM)

# calculate means and CI
library(dplyr)
tipsByDay  <- tips %>%
  group_by(day) %>%
  dplyr::summarize(
    tip.mean=mean(tip), tip.sd=sd(tip),
    length=NROW(tip),
    tfrac=qt(p=.90,df=length-1),
    lower=tip.mean-tfrac*tip.sd/sqrt(length),
    upper=tip.mean+tfrac*tip.sd/sqrt(length)
    )
tipsByDay

# now extract them from summary for tipsLM
tipsInfo  <- summary(tipsLM)
tipsCoef  <- as.data.frame(tipsInfo$coefficients[,1:2])
tipsCoef  <- within(tipsCoef, {
    Lower  <- Estimate - qt(p=0.90, df=tipsInfo$df[2])* `Std. Error` 
    Upper  <- Estimate + qt(p=0.90, df=tipsInfo$df[2])* `Std. Error`
    day  <- rownames(tipsCoef)
})

# plot them both
ggplot(tipsByDay, aes(x=tip.mean, y=day)) + geom_point() +
  geom_errorbarh(aes(xmin=lower, xmax=upper), height=.3) +
  ggtitle("Tips by day calculated manually")

ggplot(tipsCoef, aes(x=Estimate, y=day)) + geom_point() +
  geom_errorbarh(aes(xmin=Lower, xmax=Upper), height=.3) +
  ggtitle("Tips by day calculated from regression model")


##### MULTIPLE REGRESSION

housing  <- read.table("http://www.jaredlander.com/data/housing.csv",
                       sep=",", header=TRUE,
                       stringsAsFactors=FALSE)
head(housing)
# rename bad column names
names(housing)  <- c("Neighborhood", "Class", "Units", "YearBuilt", "SqFt", "Income", "IncomePerSqFt", "Expense", "ExpensePerSqFt", "NetIncome", "Value", "ValuePerSqFt", "Boro")
head(housing)
# ValuePerSqFt -> response variable
ggplot(housing, aes(x=ValuePerSqFt)) +
  geom_histogram(binwidth=10) + labs(x="Value per Square Foot")
# ValuePerSqFt separated by boro
ggplot(housing, aes(x=ValuePerSqFt, fill=Boro)) +
  geom_histogram(binwidth=10) + labs(x="Value per Square Foot")
# ValuePerSqFt separated by boro and faceted by boro
ggplot(housing, aes(x=ValuePerSqFt, fill=Boro)) +
  geom_histogram(binwidth=10) + labs(x="Vaue per Square Foot") +
  facet_wrap(~Boro)
# look at histogram for square footage and number of units
ggplot(housing, aes(x=SqFt)) + geom_histogram()
ggplot(housing, aes(x=Units)) + geom_histogram()
ggplot(housing[housing$Units < 1000,], aes(x=SqFt)) + geom_histogram()
ggplot(housing[housing$Units < 1000,], aes(x=Units)) + geom_histogram()
# scatterplots of value per sqft - against units and sqft
# see if we can remove outliers
ggplot(housing, aes(x=SqFt, y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=Units, y=ValuePerSqFt)) + geom_point()
ggplot(housing[housing$Units < 1000,], aes(x=SqFt, y=ValuePerSqFt)) + geom_point()
ggplot(housing[housing$Units < 1000,], aes(x=Units, y=ValuePerSqFt)) + geom_point()
# how many need to be removed
sum(housing$Units >= 1000)
# remove them
housing  <- housing[housing$Units < 1000,]
# log transforming data
ggplot(housing, aes(x=SqFt, y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=log(SqFt), y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=SqFt, y=log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x=log(SqFt), y=log(ValuePerSqFt))) + geom_point()
# plot ValuePerSqFt against Units
ggplot(housing, aes(x=Units, y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=log(Units), y=ValuePerSqFt)) + geom_point()
ggplot(housing, aes(x=Units, y=log(ValuePerSqFt))) + geom_point()
ggplot(housing, aes(x=log(Units), y=log(ValuePerSqFt))) + geom_point()

# constructing the model
house1  <- lm(ValuePerSqFt ~ Units + SqFt + Boro, data=housing)
summary(house1)
# grab the coefficients of the model
house1$coefficients
coef(house1)
# construct a coefplot
library(coefplot)
coefplot(house1)
# interactions between variables, use * instead of +
# * indiv vars + interaction, : just interaction
house2  <- lm(ValuePerSqFt ~ Units * SqFt + Boro, data=housing)
house3  <- lm(ValuePerSqFt ~ Units:SqFt + Boro, data=housing)
coef(house3)
coefplot(house2)
coefplot(house3)
# multiple interactions 3x2 interactions and 1x3 interaction
house4  <- lm(ValuePerSqFt ~ SqFt*Units*Income, housing)
coef(house4)
coefplot(house4)
# interactions between factors
house5  <- lm(ValuePerSqFt ~ Class*Boro, housing)
coef(house5)
coefplot(house5)
# zooming in on plot
coefplot(house1, sort='mag') + scale_x_continuous(limits=c(-.25, .1))
coefplot(house1, sort='mag') + scale_x_continuous(limits=c(-.0005, .0005))
# standardizing the values of the model
house1.b  <- lm(ValuePerSqFt ~ scale(Units) + scale(SqFt) + Boro, data=housing)
coefplot(house1.b, sort='mag')
# ratio in model, use I to wrap
house6  <- lm(ValuePerSqFt ~ I(SqFt/Units) + Boro, housing)
coef(house6)

# comparing multiple models using coeffs
multiplot(house1, house2, house3)


##### USING THE PREDICT FUNCTION

housingNew  <- read.table("http://www.jaredlander.com/data/housingNew.csv",
                          sep=",", header=TRUE, stringsAsFactors=FALSE)
# make prediction with new data nd 95% confidence bounds
housePredict  <- predict(house1, newdata=housingNew, se.fit=TRUE, interval="prediction", level=.95)
# view predictions with upper and lower bounds based on std. errors
head(housePredict$fit)
# view standard errors for prediction
head(housePredict$se.fit)
