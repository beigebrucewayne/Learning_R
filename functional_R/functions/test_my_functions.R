library("testthat")

source("my_functions.R")

test_that("Test sqrt_newton: positive numeric", {
  eps  <- 0.001
  expected  <- 2
  actual  <- sqrt_newton(4, 1, eps = eps)
  expect_lt(abs(expected - actual), eps)
})

test_that("Test sqrt_newton: negative numeric", {
  expect_error(sqrt_newton(-4, 1))
})

test_that("Test sqrt_newton: not enough iterations", {
  expect_error(sqrt_newton(4, 1E100, 1E-100, iter=100))
})
