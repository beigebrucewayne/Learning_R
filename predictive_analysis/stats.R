# random sample of 100 nums between 1 and 100
x  <- sample(x=1:100, size=100, replace=TRUE)
mean(x)

y  <- x
# randomly make 20% NA values
y[sample(x=1:100, size=20, replace=FALSE)]  <- NA
y
# remove NA before calculating mean
mean(y, na.rm=TRUE)

# weighted mean
grades  <- c(95, 72, 87, 66)
weights  <- c(1/2, 1/4, 1/8, 1/8)
mean(grades)
weighted.mean(x=grades, w=weights)

# variance
var(x)
# std dev - square root of variacne
sd(x)
min(x)
max(x)
median(x)

# summary() - calcs mean, min, max and median
summary(x)

# quantile() - shows quantiles
# calc 25th and 75th quantile
quantile(x, probs=c(.25, .75))


##### CORRELATION & COVARIANCE


head(economics)
cor(economics$pce, economics$psavert)

# compute multiple vars at once, use cor on a matrix
cor(economics[,c(2,4:6)])
cor(diamonds[,c(1,5:10)])

# create correlation plot matrix
GGally::ggpairs(economics[,c(2,4:6)])


# CORRELATION HEAT MAP


library(reshape2)
library(scales)
# build correlation matrix
econCor  <- cor(economics[,c(2, 4:6)])
# melt it into the long format
econMelt  <- melt(econCor, varnames=c("x", "y"), value.name="Correlation")
# order according to correlation
econMelt  <- econMelt[order(econMelt$Correlation),]
# display melted data
econMelt

## plot with ggplot

ggplot(econMelt, aes(x=x, y=y)) +
  # draw tiles filling color based on correlation
  geom_tile(aes(fill=Correlation)) +
  # fill color = 3 color gradient - red = low, white = middle, blue = high
  # guide is colorbar w/ no ticks, height = 10 lines, scale filled from -1 to 1
  scale_fill_gradient2(low=muted("red"), mid="white", high="steelblue",
                       guide=guide_colorbar(ticks=FALSE, barheight=10),
                       limits=c(-1,1)) + theme_minimal() + labs(x=NULL, y=NULL)

# dealing with NA in cor()
cor(theMat, use="complete.obs")
cor(theMat, use="na.or.complete")

# crazy graph data dump
head(tips)
GGally::ggpairs(tips)

# covariance - cov()
cov(economics$pce, economics$psavert)
cov(economics[,c(2,4:6)])


##### T-TESTS


# t-test - test on the mean, comparing two sets of data
head(tips)
unique(tips$sex)
unique(tips$day)

# one sample t-test
t.test(tips$tip, alternative="two.sided", mu=2.50)

# build a t distribution
randT  <- rt(30000, df=NROW(tips)-1)
# get t-statistic and other info
tipTTest  <- t.test(tips$tip, alternative="two.sided", mu=2.50)
# plot it
ggplot(data.frame(x=randT)) +
  geom_density(aes(x=x), fill="blue", color="grey") +
  geom_vline(xintercept=tipTTest$statistic) +
  geom_vline(xintercept=mean(randT) + c(-2,2)*sd(randT), linetype=2)

# one sample t-test, mean > 2.50
t.test(tips$tip, alternative="greater", mu=2.50)

# two-sample t-test

# histogram of tip amount by sex
# compute var of each group, calc var of tip for each level of sex
aggregate(tip ~ sex, data=tips, var)
# test for normality of tip distribution
shapiro.test(tips$tip)
shapiro.test(tips$tip[tips$sex == "Female"])
shapiro.test(tips$tip[tips$sex == "Male"])
# all tests fail so inspect visually
ggplot(tips, aes(x=tip, fill=sex)) +
  geom_histogram(binwidth=.5, alpha=1/2)


##### ANOVA


tipAnova  <- aov(tip ~ day - 1, tips) # correct way
tipIntercept  <- aov(tip ~ day, tips)
tipAnova$coefficients
tipIntercept$coefficients
