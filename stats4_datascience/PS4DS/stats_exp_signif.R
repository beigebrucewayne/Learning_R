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
  # exhaustive permutation test - find all possible ways data could be divided
  # bootstrap permutation test - with replacement


##### STATISTICAL SIGNIF & P-VALUE

# p-value - probability of obtaining results as unusual or extreme as the observed results
# alpha - probability threshold of "unusualness", chance results must surpass, for actual outcomes to be deemed statistically significant
# type 1 error - conducting an effect is real (when it is due to chance)
# type 2 error - conducting an effect is due to chance (when it is real)

obs_pct_diff  <- 100*(200/23739 - 182/22588)
conversion  <- c(rep(0, 45945), rep(1, 382))
perm_diffs  <- rep(0, 1000)
for(i in 1:1000)
  perm_diffs[i] = 100*perm_fun(conversion, 23739, 22588)
hist(perm_diffs, xlab='Sesstion time differences (in seconds)')
abline(v = obs_pct_diff)

# p-value
mean(perm_diffs > obs_pct_diff)

# since data is binomial dist, use prop.test to get p-value
prop.test(x=c(200,182), n=c(23739,22588), alternative="greater")

# t-tests

# test statistic - metric for difference or effect of interest
# t-statistic - standardized version of the test statistic
# t-distribution - reference distribution, which obs t-stat can be compared

# t.test()
t.test(Time ~ Page, data=session_times, alternative='less')


##### MULTIPLE TESTING

# type 1 error - mistakenly concluding effect is statistically significant
# false discovery rate - rate of making type 1 error
# adjustment of p-values - doing multiple tests on the same data
# overfitting - fitting the noise


##### DEGREES OF FREEDOM

# n (sample size) - numbers of obs in data
# df - degrees of freedom

# essentially solving the problem of dummy variables, you omit one because otherwise it would be redundant


##### ANOVA - compare across multiple groups A-B-C-D, each with numeric data

# pairwise comparison - hypothesis test between two groups among multiple groups
# omnibus test - single hypothesis test of overall variance among multiple group means
# decomposition of variance - separation of components, contributing to individual value
# f-statistic - stat to measure extent that differences among groups exceeds what might be expected in a chance model
# SS (sum of squares) - deviations from some average value

library(lmPerm)
summary(aovp(Time ~ Page, data=four_sessions))


##### F-STATISTIC

# based on ratio of variance across group means to the variance due to residual error
# higher the ration, the more significant

# compute ANOVA table using aov()
summary(aov(Time ~ Page, data=four_sessions))


##### TWO-WAY ANOVA

# two factors varying

# ANOVA - stats procedure for analyzing results of experiment with multiple groups
# extension of A/B test
# ANOVA output identifies variance of components


##### CHI-SQUARED TEST

# used for count data, how well it fits expected distribution

# chi-square statistic - measure of extent some obs deviate from expectation
# expectation or expected - how we expect data to ouput, null hypothesis
# df - degrees of freedom

# chi-squared test - resampling approach

chisq.test(clicks, simulate.p.value=TRUE)

# degrees of freedom - chi squared test
degrees_of_freedom  <- (r - 1) * ( c - 1 )


##### FISHER'S EXACT TEST

fisher.test(clicks)
