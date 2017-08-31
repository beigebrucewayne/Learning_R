# dataframe -> tibble
as_tibble(iris)

# create tibble from individual vector
tibble(x = 1:5, y = 1, z = x ^ 2 + y)


# two differences between tibble and dataframe - printing & subsetting

# printing dataframe - n = rows, width = how wide
nycflights13::flights %>%
    print(n = 10, width = Inf)

# subsetting - $ -> by name; [[]] -> by name or position
df  <- tibble(x = runif(5), y = rnorm(5))
df$x
df[["x"]]
df[[1]]

# turn tibble back to dataframe
as.data.frame(tb)
