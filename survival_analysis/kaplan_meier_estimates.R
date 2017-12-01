# survfit(formula, conf.int = 0.95, conf.type = "log")

library(OIsurv)

data(tongue); attach(tongue)

my.surv  <- Surv(time[type == 1], delta[type == 1])

# simplest -> survival object against intercept
survfit(my.surv ~ 1)

my.fit  <- survfit(my.surv ~ 1)

# returns K-M estimate at each t_i
summary(my.fit)$surv
# {t_i}
summary(my.fit)$time
# {Y_i}
summary(my.fit)$n.risk
# {d_i}
summary(my.fit)$n.event
# std. err of K-M estimate at {t_i}
summary(my.fit)$std.err
# lower pointwise estimates
summary(my.fit)$lower
# full summary
str(summary(my.fit))

# Plotting K-M estimates
plot(my.fit, main = "Kaplan-Meier estimate with 95% confidence bounds",
     xlab = "time",
     ylab = "survival function")

# K-M estimate for each DNA group
my.fit1  <- survfit(Surv(time, delta) ~ type)

plot(my.fit1)
