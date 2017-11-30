library(survival)
library(ranger)
library(ggplot2)
library(dplyr)
library(ggfortify)

data(veteran)
head(veteran)
#   trt celltype time status karno diagtime age prior
# 1   1 squamous   72      1    60        7  69     0
# 2   1 squamous  411      1    70        5  64    10
# 3   1 squamous  228      1    60        3  38     0
# 4   1 squamous  126      1    60        9  63    10
# 5   1 squamous  118      1    70       11  65    10
# 6   1 squamous   10      1    20        5  49     0


### KAPLAN - MEIER ###


# Surv() -> create survival object

# time -> survival time
# status -> death (status = 1), censored (status = 0)

# Kaplan Meier Survival Curve
km  <- with(veteran, Surv(time, status))
head(km, 80)

# Produce Kap-Meier estimates of probability of survival over time
km_fit  <- survfit(Surv(time, status) ~ 1, data = veteran)
summary(km_fit, times = c(1, 30, 60, 90 * (1:10)))

autoplot(km_fit)

# survival curves by treatment
km_trt_fit  <- survfit(Surv(time, status) ~ trt, data = veteran)
autoplot(km_trt_fit)

# survival by age
vet  <- mutate(veteran, AG = ifelse((age < 60), "LT60", "OV60"),
               AG = factor(AG),
               trt = factor(trt, labels = c("standard", "test")),
               prior = factor(prior, labels = c("NO", "YES")))

km_AG_fit  <- survfit(Surv(time, status) ~ AG, data = vet)
autoplot(km_AG_fit)


### COX PRPORTIONAL HAZARD ###


cox  <- coxph(Surv(time, status) ~ trt + celltype + karno + diagtime + age + prior, data = vet)
summary(cox)

cox_fit  <- survfit(cox)

autoplot(cox_fit)

# Cox Assumptions

  # Covariates do not vary with time


# Fitting Aalen Additive Regression Model
aa_fit  <- aareg(Surv(time, status) ~ trt + celltype + karno + diagtime + age + prior, data = vet)
summary(aa_fit)
autoplot(aa_fit)


### RANGER ###


# Ranger -> Random Forest Ensemble model

  # builds model for each obs in data set
  # builds model w/ same vars in Cox model above
  # plots 20 random curves

# ranger model
r_fit  <- ranger(Surv(time, status) ~ trt + celltype + karno + diagtime + age + prior,
  data = vet,
  mtry = 4,
  importance = "permutation",
  splitrule = "extratrees",
  verbose = TRUE)

summary(r_fit)

# average survival models
death_times  <- r_fit$unique.death.times
surv_prob  <- data.frame(r_fit$survival)
avg_prob  <- sapply(surv_prob, mean)

# plot survival models for each patient
plot(r_fit$unique.death.times, r_fit$survival[1,],
     type = "l",
     ylim = c(0, 1),
     col = "red",
     xlab = "Days",
     ylab = "survival",
     main = "Patient Survival Curves")

cols  <- colors()
for (n in sample(c(2:dim(vet)[1]), 20)) {
  lines(r_fit$unique.death.times, r_fit$survival[n,], type = "l", col = cols[n])
}

lines(death_times, avg_prob, lwd = 2)
legend(500, 0.7, legend = c('Average = black'))


# ranger -> ranking variable importance

vi  <- data.frame(sort(round(r_fit$variable.importance, 4), decreasing = TRUE))
names(vi)  <- "importance"
head(vi)

# plot all 3 methods

kmi  <- rep("KM", length(km_fit$time))
km_df  <- data.frame(km_fit$time, km_fit$surv, kmi)
names(km_df)  <- c("Time", "Surv", "Model")

coxi  <- rep("Cox", length(cox_fit$time))
cox_df  <- data.frame(cox_fit$time, cox_fit$surv, coxi)
names(cox_df)  <- c("Time", "Surv", "Model")

rfi  <- rep("RF", length(r_fit$unique.death.times))
rf_df  <- data.frame(r_fit$unique.death.times, avg_prob, rfi)
names(rf_df)  <- c("Time", "Surv", "Model")

plot_df <- rbind(km_df, cox_df, rf_df)

p  <- ggplot(plot_df, aes(x = Time, y = Surv, color = Model))
p + geom_line()
