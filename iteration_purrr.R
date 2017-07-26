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
