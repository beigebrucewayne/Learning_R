####################
# Function Components
####################

f  <- function(x) x^2

# Every function has 3 parts

# list of arguments
formals(f)
# code inside function
body(f)
# map of location of function's variables
environment(f)


####################
# Primitive Functions
####################

sum()

# calls C code directly, no R code

objs  <- mget(ls("package:base"), inherits = TRUE)
funs  <- Filter(is.function, objs)


####################
# Lexical Scoping
####################

# lexical scoping - implemented automatically at language level
# dynamic scoping - used in select functions to save typing during interactive analysis


# Name Masking

f  <-  function() {
  y  <- 1
  x  <- 2
  c(x, y)
}

# if name isn't defined inside function, R looks one level up
x  <- 2
g  <- function() {
  y  <- 1
  c(x, y)
}

# same rule applies for functions
x  <- 1
h  <- function() {
  y  <- 2
  i  <- function() {
    z  <- 3
    c(x, y, z)
  }
  i()
}

j  <- function(x) {
  y  <- 2
  function() {
    c(x, y)
  }
}


# Functions vs. Variables

l  <- function(x) x + 1
m  <- function() {
  l  <- function(x) x + 2
  l(10)
}


# Fresh start

j  <- function() {
  if(!exists("a")) {
    a  <- 1
  } else {
    a  <- a + 1
  }
  a
}


# Dynamic lookup

f  <- function() x
x  <- 15
x  <- 20



####################
# Every Operation Is A Function Call
####################

add  <- function(x, y) x + y
# function (x, y) 
# x + y
sapply(1:10, add, 3)
sapply(1:5, `+`, 3)
# [1] 4 5 6 7 8

x  <- list(1:3, 4:9, 10:12)
sapply(x, "[", 2)
# equivalent to
sapply(x, function(x) x[2])

# everything in R is a funciton call


####################
# Function Arguments
####################

f  <- function(abcdef, bcde1, bcde2) {
  list(a = abcdef, b1 = bcde1, b2 = bcde2)
}

str(f(1, 2, 3))
str(f(2, 3, abcdef = 1))
# abbreviate long arg names
str(f(2, 3, a = 1))
# doesn't work because arg abbrev is ambiguous
str(f(1, 3, b = 1))


####################
# Calling Function -> list of args
####################

args  <- list(1:10, na.rm = TRUE)
do.call(mean, args)
# equivalent
mean(1:10, na.rm = TRUE)


####################
# Default & Missing Args
####################

# funcs can have default values
f  <- function(a = 1, b = 2) {
  c(a, b)
}
f()
# [1] 1 2

g  <- function(a = 1, b = a * 2) {
  c(a, b)
}
g()
g(10)

# determine whether an argument is missing
i  <- function(a, b) {
  c(missing(a), missing(b))
}
i()
# [1] TRUE TRUE
i(10)
# [1] FALSE  TRUE


####################
# Lazy Evaluation
####################

# R function args are lazy, only evaluated if used
f  <- function(x) 10
f(stop("This is an error!"))
# make sure arg is evaluated, use foce()
f  <- function(x) {
  force(x)
  10
}
f(stop("This is an error!"))

# important for closures using lapply() or loop
add  <- function(x) {
  function(y) x + y
}
adders  <- lapply(1:10, add)
adders[[1]](10)

add  <- function(x) {
  force(x)
  function(y) x + y
}
adders2  <- lapply(1:10, add)
adders2[[1]](10)

f  <- function(x = ls()) {
  a  <- 1
  x
}
f()
f(ls())

# unevaluated arg == promise
    # expression that gives rise to delayed computation
    # environment where expression was created and wehre it should be evaluated

x  <- NULL
if (!is.null(x) && x > 0){
}
