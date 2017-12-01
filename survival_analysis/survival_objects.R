# Surv(time, event)

# Surv(time, time2, event, type)

library(OIsurv)

# right-censored data

  # vector -> times
  # vector -> which times are observed and censored

data(tongue)
attach(tongue)

dim(tongue)
# [1] 80  3

head(tongue)
#   type time delta
# 1    1    1     1
# 2    1    3     1
# 3    1    3     1
# 4    1    4     1
# 5    1   10     1
# 6    1   13     1

# create subset for for first group
mySurvObject  <- Surv(time[type == 1], delta[type == 1])
mySurvObject

detach(tongue)

# + -> observations are right-censored

# lef-truncated right-censored data 

  # left-truncation times entered fist
  # vector -> events + censored times
  # vector -> indicator right-censoring

data(psych); attach(psych)

mySurvObject  <- Surv(age, age+time, death)
mySurvObject
