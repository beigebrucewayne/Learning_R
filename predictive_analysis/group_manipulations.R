# dplyr basic grammar

# select - selecting columns
# filter - filtering rows
# group_by - grouping data
# mutate - changing or adding columns

# purpose of magrittr

# old way
data(diamonds, package='ggplot2')
dim(head(diamonds, n=4)) # dim = dimensions

# using the pipe
diamonds %>% head(4) %>% dim

# selecting columns
select(diamonds, carat, price)
carat_price  <- select(diamonds, carat, price)
