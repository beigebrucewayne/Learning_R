# for loop
df  <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10), 
  d = rnorm(10)
)

output  <- vector("double", ncol(df))
for (i in seq
  output[[i]]  <- median(df[[i]])
}

# for loop - 3 components
# output - vector() - two arguments (type, length)
    # type - logical, integer, double, character, etc...
# sequence
# body

# 4 Variants of For Loops

# Modifying existing object, instead of creatign a new one

df  <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

rescale01  <- function(x) {
  rng  <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

# implement for loop to apply rescale01 to each column
for (i in seq_along(df)) {
  df[[i]]  <- rescale01(df[[i]])
}

# Looping over names or values, instead of indices

for (x in xs) # loop over elements
for (nm in names(xs)) # loop over the names

results  <- vector("list", length(x))
names(results)  <- names(x)

# extract both name and value
for (in seq_along(x)) {
  name  <- name(x)[[i]]
  value  <- x[[i]]
}

# Handling outputs of unknown length
means  <- c(0, 1, 2)

out  <- vector("list", length(means))
for (i in seq_along(means)) {
  n  <- sample(100, 1)
  out[[i]]  <- rnorm(n, means[[i]])
}

str(out)
str(unlist(out)) # flatten out a list of vectors

# Handling sequences of unknown length

# 3 heads in a row (using a while loop)
flip  <- function() sample(c("T", "H"), 1)

flips  <- 0
nheads  <- 0

while (nheads < 3) {
  if (flip() == "H") {
    nheads  <- nheads + 1  
  } else {
    nheads  <- 0  
  }
  flips  <- flips + 1
}


# functional programming - purr

# map funcitons
map() # makes a list
map_lgl() # makes a logical vector
map_int() # makes an integer vector
map_dbl() # double vector
map_chr() # character vector

# using map functions - taking function applying to vector
map(df, mean)
map_dbl(df, median)
map_dbl(df, sd)

# map functions using the pipe
df %>% map_dbl(mean)
df %>% map_dbl(median)
df %>% map_dbl(sd)

# second argument of map can be:
    # formula
    # character vector
    # integer vector

# shortcuts
models  <- mtcars %>%
    split(.$cyl) %>%
    map(function(df) lm(mpg ~ wt, data = df))

# anonymous function - purr shortcut
models  <- mtcars %>%
    splti(.$cyl) %>%
    map(~lm(mpg ~ wt, data = .))

models %>%
    map(summary) %>%
    map_dbl(~.$r.squared)

# even shorter shortcut - using string
models %>%
    map(summary) %>%
    map_dbl("r.squared")

# using integer to select
x  <- list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9))
x %>% map_dbl(2) # 2 5 8

# safely() - dealing with failures
x  <- list(1, 10, "a")
y  <- x %>% map(safely(log))
str(y)

# possibly() - specify value to return if failure
x  <- list(1, 10, "a")
x %>% map_dbl(possibly(log, NA_real_))

# quietly() - captures errors, printed output + warnings
x  <- list(1, -1)
x %>% map(quietly(log)) %>% str()

# mapping over multiple arguments

# random normals with different means
mu  <- list(5, 10, -3)
mu %>%
    map(rnorm, n = 5) %>%
    str()

# changing sd() as well
sigma  <- list(1, 5, 10)
seq_along(mu) %>%
    map(~rnorm(5, mu[[.]], sigma[[.]])) %>%
    str()

# using map2() to iterate over multiple inputs
# iterate over two vectors in parallel
map2(mu, sigma, rnorm = 5) %>% str()

# using pmap() for extended arguments
n  <- list(1, 3, 5)
args1  <- list(n, mu, sigma)
args1 %>%
    pmap(rnorm) %>%
    str()
