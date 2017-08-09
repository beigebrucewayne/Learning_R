# [[[ MAP ]]]

# applies function to each element of a list - same as lapply

# list w/ 4 elements -> apply sum function using lapply
theList  <- list(A=matrix(1:9,3), B=1:5, C=matrix(1:4,2), D=2)
lapply(theList, sum)

# using map()
library(purrr)
theList %>% map(sum)

# anonymous function to solve NA values
theList2 %>% map(function(x) sum(x, na.rm=TRUE))

# specifying in map() function
theList %>% map(sum, na.rm=TRUE)


# [[[ MAP WITH SPECIFIED TYPES ]]]

# map -> list (always)

map() # list
map_int() # integer
map_dbl() # numeric
map_chr() # character
map_lgl() # logical
map_df() # data.frame

# using to apply mean
theList %>% map_dbl(mean)

# map_if()
theList %>% map_if(is.matrix, function(x) x * 2)

# calculate means of numeric columns in diamonds data
data(diamonds, package='ggplot2')
diamonds %>% map_dbl(mean)
