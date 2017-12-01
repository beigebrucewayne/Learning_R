library(OIsurv)

data(drug6mp); attach(drug6mp)

mySurv  <- Surv(t1, rep(1, 21))
survfit(mySurv ~ 1)

# grab mean surv time and std. err
print(survfit(mySurv ~ 1), print.rmean = TRUE)
