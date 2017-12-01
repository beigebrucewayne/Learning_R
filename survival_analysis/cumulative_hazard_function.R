# MLE Hazard Function -> inverse transformation of K-M estimate

library(OIsurv)

data(tongue); attach(tongue)

mySurv  <- Surv(time[type == 1], delta[type == 1])
myFit  <- summary(survfit(mySurv ~ 1))

H.hat  <- -log(myFit$surv)
H.hat  <- c(H.hat, tail(H.hat, 1))

h.sort.of  <- myFit$n.event / myFit$n.risk
H.tilde  <- cumsum(h.sort.of)
H.tilde  <- c(H.tilde, tail(H.tilde, 1))

plot(c(myFit$time, 250), H.hat,
     xlab = "time",
     ylab = "cumulative hazard",
     main = "comparing cumulative hazards",
     ylim = range(c(H.hat, H.tilde)),
     type = "s")

points(c(myFit$time, 250), H.tilde,
       lty = 2,
       type = "s")

legend("topleft", legend = c("H.hat", "H.tilde"), lty = 1:2)
