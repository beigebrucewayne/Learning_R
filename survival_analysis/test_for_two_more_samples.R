# survdiff(formula, rho = 0)

library(OIsurv)

# Given 2 > more samples, is there a statistical difference between survival times?

# Ti -> times events observed
# Dik -> # of observed events from group K at time Ti
# Yik -> # of subjects in group K that are at risk at time Ti
# Di -> Enj = 1^Dij
# Yi -> Enj = 1^Yij
# W(Ti) -> weight of observations at time Ti

# survdiff()
  # 1st arg -> survival object
  # 2nd arg -> rho, designates weights
    # greater weight to first part of curve, rho > 0
    # greater weight to later part, rho < 0

data(btrial); attach(btrial)
survdiff(Surv(time, death) ~ im)

survdiff(Surv(time, death) ~ im, rho = 1)
