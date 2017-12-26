# chapter 3

library(MASS)

data(iris)

Y <- matrix(iris[,1])
X <- matrix(seq(0, 149, 1))

olsExample <- function(y = Y, x = X) {
  y_h <- lm(y ~ x)
  y_hf <- y_h$fitted.values
  error <- sum((y_hf - y)^2)
  coefs <- y_h$coefficients
  output <- list("Cost" = error, "Coefficients" = coefs)
  return(output)
}

# Gradient descent without adaptive step
gradientDescent <- function(y = Y, x = X, alpha = .0001, epsilon = .000001, maxiter = 300000) {
  # initialize parameters
  theta0 <- 0
  theta1 <- 0
  cost <- sum(((theta0 + theta1*x) -y)^2)
  converged <- FALSE
  iterations <- 1
  # gradient descent algorithm
  while (converged == FALSE) {
    gradient0 <- as.numeric((1/length(y))*sum((theta0 + theta1*x) - y))
    gradient1 <- as.numeric((1/length(y))*sum(((theta0 + theta1*x) - y)*x))

    t0 <- as.numeric(theta0 - (alpha*gradient0))
    t1 <- as.numeric(theta1 - (alpha*gradient1))

    theta0 <- t0
    theta1 <- t1

    error <- as.numeric(sum(((theta0 + theta1*x) -y)^2))

    if (as.numeric(abs(cost - error)) <= epsilon) {
      converged <- TRUE
    }

    cost <- error
    iterations <- iterations + 1

    if (iterations == maxiter) {
      converged <- TRUE
    }
  }
  output <- list("theta0" = theta0, "theta1" = theta1, "cost" = cost, "iterations" = iterations)
  return(output)
}


# gradient descent with adaptive step
adaptiveGradient <- function(y = Y, x = X, alpha = .0001, epsilon = .000001, maxiter = 300000) {
  theta0 <- 0
  theta1 <- 0
  cost <- sum(((theta0 + theta1*x) - y)^2)
  converged <- FALSE
  iterations <- 1

  # gradient descent algorithm
  while (converged == FALSE) {
    gradient0 <- as.numeric((1/length(y))*sum((theta0 + theta1*x) - y))
    gradient1 <- as.numeric((1/length(y))*sum((((theta0 + theta1*x) - y)*x)))

    t0 <- as.numeric(theta0 - (alpha*gradient0))
    t1 <- as.numeric(theta1 - (alpha*gradient1))

    delta_0 <- t0 - theta0
    delta_1 <- t1 - theta1

    if (delta_0 < theta0) {
      alpha <- alpha*1.0
    } else {
      alpha <- alpha*.50
    }

    theta0 <- t0
    theta1 <- t1
    error <- as.numeric(sum(((theta0 + theta1*x) - y)^2))

    if (as.numeric(abs(cost - error)) <= epsilon) {
      converged <- TRUE
    }

    cost <- error
    iterations <- iterations + 1

    if (iterations == maxiter) {
      converged <- TRUE
    }
  }
  output <- list("theta0" = theta0, "theta1" = theta1, "cost" = cost, "iterations" = iterations, "learning.rate" = alpha)
  return(output)
}


# ridge regression
ridgeRegression  <- function(y = Y, x = X, lambda = 1) {

  I <- diag(ncol(x))
  gamma  <- lambda*I
  beta_h  <- (ginv(t(x)%*%x + t(gamma)%*%gamma)) %*% (t(x) %*% y)
  beta_0  <- mean(y) - mean(x)*beta_h
  x  <- data.frame(x)
  y_h  <- beta_0 + (x*beta_h)
  RSS  <- sum((y - y_h)^2)
  output  <- list("cost" = RSS, "theta0" = beta_0, "theta1" = beta_h)
  return(output)

}


