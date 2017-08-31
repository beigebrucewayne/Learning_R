# two type of vectors

# Atomic vectors (homogeneous)
    # logical, integer, double, character, complex and raw

# Lists (recursive vectors) (heterogeneous)

# two properties of vectors
# type
typeof(letters) # "character"

# length
x  <- list("a", "b", "c")
length(x)

# augmented vector

# factors - built on top of integer vecotrs
# dates & date-times - built on top of numeric vecotrs
# dataframes & tibbles - built on top of lists

# Logical - three values (TRUE, FALSE, NA)
c(TRUE, FALSE, NA)

# Numeric - integer & double (R numbers dbl by default)
typeof(1) # double
# Four special values (NA, NaN, Inf, -Inf)


typeof(1L) # integer
# One special value (NA)

# helper functions
is.finite() # 0
is.infinite() # Inf
is.na() # NA
is.nan() # NaN

# coercion

# explicit coercion
as.logical()
as.integer()
as.double()
as.character()

# implicit coercion - use a vector in specific context that expects a certain type of vector

# test functions - via purr
is_logical()
is_integer()
is_double()
is_numeric()
is_character()
is_atomic()
is_list()
is_vector()

# naming vector - purr::set_names()
set_names(1:3, c("a", "b", "c"))

# subsetting

# numeric vector

x  <- c("one", "two", "three", "four", "five")
x[c(3,2,5)]

# logical vector

x  <- c(10, 3, NA, 5, 8, 1, NA)
# all non-missing values of x
x[!is.na(x)]
# all even (or misssing) values of x
x[x %% 2 == 0]

# named vector

x  <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

# recursive vectors (lists)

# basic list creation
x  <- list(1, 2, 3)

# str() - structure of list
str(x)

# list can contain other lists
z  <- list(list(1, 2), list(3, 4))

# subsetting a list
a  <- list(a = 1:3, b = "a string", c= pi, d = list(-1, -5))

# [] - extract list, result is also list
str(a[1:2]) # returns a + b

# [[]] - extracts one values
str(y[[1]])

# $ extract named elements
a$a == a[["a"]] # same thing

# augmented vectors (factors, date-times, times, and tibbles)

# factors
x  <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x) # integer
attributes(x) # $levels -> "ab" "cd" "ef" $class "factor"
