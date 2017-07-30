# Design of experiments - inductive way of creating stat test using stimulus...taking into account variance, confidence, etc...by randomization and comparison to control group

# z-score: (obs - mean) / std dev

# sample size needed

  # n = 4Z^2(r)(1-r) / (rI)^2
    # n = sample size
    # Z = confidence level
    # r = response rate
    # I = lift detection

# A/B Testing

  # Z = (rA / nA) - (rB / nB) / square root(p(1-p)*(1/nA + 1/nB))
    # p = rA + rB / nA + nB

  # significant if Z > 1.96 ( or 95% CI )
