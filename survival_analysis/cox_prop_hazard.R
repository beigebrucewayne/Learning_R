# coxph(formula, method)

library(OIsurv)
library(ggplot2)
library(ggfortify)

# Cox PH -> fits survival data with covariates to hazard function

data(burn); attach(burn)
head(burn)
#   Obs Z1 Z2 Z3 Z4 Z5 Z6 Z7 Z8 Z9 Z10 Z11 T1 D1 T2 D2 T3 D3
# 1   1  0  0  0 15  0  0  1  1  0   0   2 12  0 12  0 12  0
# 2   2  0  0  1 20  0  0  1  0  0   0   4  9  0  9  0  9  0
# 3   3  0  0  1 15  0  0  0  1  1   0   2 13  0 13  0  7  1
# 4   4  0  0  0 20  1  0  1  0  0   0   2 11  1 29  0 29  0
# 5   5  0  0  1 70  1  1  1  1  0   0   2 28  1 31  0  4  1
# 6   6  0  0  1 20  1  0  1  0  0   0   4 11  0 11  0  8  1

mySurv  <- Surv(T1, D1)
coxph.fit  <- coxph(mySurv ~ Z1 + as.factor(Z11), method = "breslow")
summary(coxph.fit)

# baseline survival function
mySurvfitObject  <- survfit(coxph.fit)
