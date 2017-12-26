f <- function(x) x

formals(f)
body(f)
environment(f)

## formals

g <- function(x = 1, y = 2, z = 3) x + y + z
parameters <- formals(g)
for (param in names(parameters)) {
  cat(param, "=>", parameters[[param]], "\n")
}

## function bodies

body(f)

g <- function(x) {
  y <- 2 * x
  z <- x ** 2
  x + y + z
}
body(g)

eval(body(f), list(x = 2))

h <- array()
for (i in 1:10)
  h <<- eval(body(f), list(x = i))

## delayed assignment

fenv <- new.env()
parameters <- formals(f)
for (param in names(parameters)) {
  delayedAssign(param, parameters[[param]], fenv, fenv)
}
eval(body(f), fenv)


enclosing <- function() {
  z <- 2
  function(x, y = x) {
    x + y + z
  }
}
f <- enclosing()
calling <- function() {
  w <- 5
  f(x = 2 * w)
}
calling()