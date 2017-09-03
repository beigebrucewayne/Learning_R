# square root of a number - newton's algo
sqrt_newton  <- function(a, init, eps = 0.01) { 
  while(abs(init**2 - a) > eps) {
    init  <- (1 / 2) * (init + a / init)
  }
  return(init)
}

rez  <- sqrt_newton(16, 2)


### rewrite using recursion
sqrt_newton_recur  <- function(a, init, eps=0.01) {
  if(abs(init**2 - a) < eps) {
    result  <- init  
  } else {
    init  <- 1 / 2 * (init + a / init)
    result  <- sqrt_newton_recur(a, init, eps)
  }
  return(result)
}

sqrt_newton_recur(16,2)


### properties of functions

# referential transparency - same output for given input
increment  <- function(x) {
  return(x + 1)
}

# function w/ side effect
count_iter  <- 0
sqrt_newton_side_effect  <- function(a, init, eps = 0.01) {
  while(abs(init**2 - a) > eps) {
    init  <- 1/2*(init + a/init)
    count <<- count_iter + 1 # <<- RHS value is assigned to global variable
  }
  return(init)
}

# side effect - function changed something outside it's scope

# function NO side effects
sqrt_newton_count  <- function(a, init, count_iter=0, eps=0.01) {
  while(abs(init**2 - a) > eps) {
    init  <- 1/2*(init + a/init)
    count_iter  <- count_iter + 1
  }
  return(c(init, count_iter))
}


# MAPPING + REDUCING => BASE R

numbers  <- c(16, 25, 36, 49, 64, 81)
sqrt_newton(numbers, init = rep(1, 6), eps = rep(0.001, 6))

# using map to solve problem
Map(sqrt_newton, numbers, init=1)

# map - applies function to every element of a list and returns a list

# wrapper around Map()
sqrt_newton_vec  <- function(numbers, init, eps=0.01) {
  return(Map(sqrt_newton, numbers, init, eps))
}

sqrt_newton_vec(numbers, 1)


### BASE R - Higher Order Functions

Map(
apply()
lapply()
mapply()
sapply()
vapply()
tapply()


# row wise sum
a  <- cbind(c(1,2,3), c(4,5,6), c(7,8,9))
apply(a, 1, sum)

# also could use lapply() or sapply()
lapply(numbers, sqrt_newton, init=1)

# rewrite with better looking result
sqrt_newton_vec  <- function(numbers, init, eps=0.01) {
  return(sapply(numbers, sqrt_newton, init, eps))
}
sqrt_newton_vec(numbers, 1)


### REDUCE()

Reduce(`+`, numbers, init=0)

# basic min function
my_min  <- function(a, b) {
  if(a < b) {
    return(a) 
  } else {
    return(b)  
  }
}

# minimum of a list of numbers
Reduce(my_min, numbers)
Reduce(min, numbers)


### Mapping and Reducing: the purrr way


library("purrr")
a  <- seq(1,10)
is_multiple_of_two  <- function(x) {
  ifelse(x %% 2 == 0, TRUE, FALSE)
}
map_if(a, is_multiple_of_two, sqrt)

# reducing wiht purrr

a  <- seq(1,10)
reduce(a, `-`)
reduce_right(a, `-`)
accumulate(a, `-`)
accumulate_right(a, `-`)

# useful funcitons from purrr

a  <- list("a", 4, 5)
sqrt(a) # error
safe_sqrt  <- safely(sqrt)
map(a, safe_sqrt)

possibly() # specify return value in case of an error
possible_sqrt  <- possibly(sqrt, otherwise = NA_real_)
map(a, possible_sqrt)
sqrt(as.numeric(a))

transpose() # lists:
safe_sqrt  <- safely(sqrt, otherwise = NA_real_)
map(a, safe_sqrt)
transpose(map(a, safe_sqrt))


### anonymous functions

data(mtcars)
head(mtcars)
library(purrr)
mtcars2000  <- mtcars
mtcars2001  <- mtcars
mtcars2001$cyl  <- mtcars2001$cyl+3
datasets  <- list("mtcars2000" = mtcars2000, "mtcars2001" = mtcars2001)
map(datasets, hist, cyl) # error 'x' must be numeric
map(datasets, (function(x) hist(x$cyl)))
map2(
     .x = datasets, .y=names(datasets),
     (function(.x, .y) hist(.x$cyl, main=paste("Histogram of cyl in", .y)))
)
