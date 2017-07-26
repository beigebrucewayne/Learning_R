# 60% - training data
# 20% - query set (data to compare models or viusalize)
# 20% - test set (for testing final model)

# basic firs step graphing of data
ggplot(sim1, aes(x, y)) + geom_point()

# very general model (applying a shit ton of lines to graph)
models  <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)
 ggplot(sim1, aes(x, y)) +
     geom_abline(
                 aes(intercept = a1, slope = a2),
                 data = modesl, alpha = 1/4
) +
geom_point()
