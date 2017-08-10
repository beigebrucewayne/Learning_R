# classical statistical inference pipeline

# Formulate Hypothesis ->
# Design Experiment ->
# Collect Data ->
# Inference / Conclusions

##### A/B TESTING

# treatment - something to which a subject is exposed
# treatment group - group of subjects exposed to treatment
# control group - group of subjects (not exposed) to treatment
# randomization - randomly assigning subjects to treatments
# subjects - items exposed to treatments
# test statistic - metric used to measure effect of treatment

##### HYPOTHESIS TESTS

# null hypothesis - the hypothesis that chance is to blame
# alternate hypothesis - counterpoint to the null (what is hoped to be proven)
  # null = no difference between A and B, alt = A is different from B
  # null = A < B, alt = A > B
# one-way test - hypothesis test that counts chance results only in one direction
# two-way test - hypothesis counts chance results in two directions

##### RESAMPLING

# permutation test - combining two or more samples together, and randomly (exhaustively) reallocating the observations to resamples
    # with or without replacement - whether item is returned or not
  # 1. combine results from different groups into single data set
  # 2. shuffle combined data, randomly draw a resample of A
  # 3. randomly draw resample of size B
  # 4. same for groups C, D, and so on...
  # 5. calculate original statistics or estimates for new samples (same ones used orginally)
  # 6. repeat previous steps R times to yield permutation distribution of test statistic

# looking at session_time A / B test
ggplot(session_times, aes(x=Page, y=Time)) +
  geom_boxplot()
# group B -> longer sessions
mean_a  <- mean(session_times[session_times['Page'] == 'Page A', 'Time'])
mean_b  <- mean(session_times[session_times['Page'] == 'Page B', 'Time'])
mean_b - mean_a

# permutation function
perm_fun  <- function(x, n1, n2) {
  n  <- n1 + n2
  idx_b  <- sample(1:n, n1)
  idx_a  <- setdiff(1:n, idx_b)
  mean_diff  <- mean(x[idx_b]) - mean(x[idx_a])
  return(mean_diff)
}

# plotting results to histogram
perm_diffs  <- rep(0, 1000)
for(i in 1:1000)
  perm_diffs[i] = perm_fun(session_times[, 'Time'], 21, 15)
hist(perm_diffs, xlab='Session time differences (in seconds)')
abline(v = mean_b - mean_a)

# bootstrap permutation test
