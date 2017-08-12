##### LOGISTIC REGRESSION

acs <- read.table("http://jaredlander.com/data/acs_ny.csv", sep=",", header=TRUE, stringsAsFactors = FALSE)

# logistic regression formula
# p(yi = 1) = logit ^(-1) * (XiB)

# does household have an income > $150,000
# new variable: TRUE if > $150,000...otherwise FALSE

acs$Income <- with(acs, FamilyIncome >= 150000)
library(ggplot2)
library(useful)
ggplot(acs, aes(x=FamilyIncome)) +
  geom_density(fill="grey", color="grey") +
  geom_vline(xintercept=150000) +
  scale_x_continuous(label=multiple.dollar, limits=c(0, 1000000))
head(acs)

# logistic regression -> glm()
income1  <- glm(Income ~ HouseCosts + NumWorkers + OwnRent + NumBedrooms + FamilyType, data=acs, family=binomial(link="logit"))
summary(income1)
library(coefplot)
coefplot(income1)
# interpreting coefficients form logistic regression -> inverse logit
invlogit  <- function(x) {
  1 / (1 + exp(-x))
}
invlogit(income1$coefficients)


##### POISSON REGRESSION

ggplot(acs, aes(x=NumChildren)) + geom_histogram(binwidth=1)
# poisson regression
children1  <- glm(NumChildren ~ FamilyIncome + FamilyType + OwnRent, data=acs, family=poisson(link="log"))
summary(children1)
coefplot(children1)
# standardized residuals
z  <- (acs$NumChildren - children1$fitted.values) / sqrt(children1$fitted.values)
# overdispersion factor
sum(z^2) / children1$df.residual # overdisperion ratio > 2 = overdispersion
# overdispersion p-value
pchisq(sum(z^2), children1$df.residual) # 1 = stat signif overdispersion
# refit model using quasipoisson (negative binomial distribution)
children2  <- glm(NumChildren ~ FamilyIncome + FamilyType + OwnRent, data=acs, family=quasipoisson(link="log"))
multiplot(children1, children2)


##### SURVIVAL ANALYSIS

library(survial)
head(bladder)

# stop - when event occurs, patient leaves study
# event - whether event occured at the time

# look at piece of data
bladder[100:105,]

# response variable built by build.y
survObject <- with(bladder[100:105,], Surv(stop, event))
survObject
# matrix form
survObject[,1:2]


##### COX PROPORTIONAL HAZARD MODEL

cox1 <- coxph(Surv(stop, event) ~ rx + number + size + enum, data=bladder)
summary(cox1)


plot(survfit(cox1), xlab="Days", ylab="Survival Rate", conf.int=TRUE)

cox2 <- coxph(Surv(stop, event) ~ strata(rx) + number + size + enum, data=bladder)
summary(cox2)

plot(survfit(cox2), xlab="Days", ylab="Survival Rate", conf.int=TRUE, col=1:2)
legend("bottomleft", legend=c(1,2), lty=1, col=1:2, text.col=1:2, title="rx")

# test assumption of coxph with cox.zph
cox.zph(cox1)
cox.zph(cox2)


##### ANDERSON-GILL ANALYSIS

head(bladder2)
ag1 <- coxph(Surv(start, stop, event) ~ rx + number + size + enum + cluster(id), data=bladder2)
ag2 <- coxph(Surv(start, stop, event) ~ strata(rx) + number + size + enum + cluster(id), data=bladder2)
plot(survfit(ag1), conf.int=TRUE)
plot(survfit(ag2), conf.int=TRUE, col=1:2)
legend("topright", legend=c(1,2), lty=2, col=1:2, text.col=1:2, title="rx")
