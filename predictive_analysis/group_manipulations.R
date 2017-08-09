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


############### SELECT #####################


# selecting columns
select(diamonds, carat, price)
carat_price  <- select(diamonds, carat, price)

# using the pipe
diamonds %>% select(carat, price)
diamonds %>% select(c(carat, price)) # columns as vector of col names
diamonds %>% select_('carat', 'price') # standard eval version of select, for 'strings'
diamonds %>% select(one_of('carat', 'price')) # select_() = deprecated

# column names stored as variable
theCols  <- c('carat', 'price')
diamonds %>% select_(.dots=theCols)
diamonds %>% select(one_of(theCols))

# traditional r square brackets
diamonds[,c('carat', 'price')]

# using col names as indices
select(diamonds, 1, 7)
diamonds %>% select(1, 7)

# columns with partial match - starts_with(), ends_with(), contains()
diamonds %>% select(starts_with('c'))

# columsn using regex
diamonds %>% select(matches('r.+t'))

# not select columns
diamonds %>% select(-carat, -price)


################ FILTER ###################


# rows based off of a logical expression
diamonds %>% filter(cut == 'Ideal')
diamonds %>% filter(price >= 1000)
diamonds %>% filter(price != 1000)

# base R
diamonds[diamonds$cut == 'Ideal',]

# filter column equal on one of many possiblities
diamonds %>% filter(cut %in% c('Ideal', 'Good'))

# combine filtering using , or &
diamonds %>% filter(carat > 2, price < 14000)

# using the or statement
diamonds %>% filter(carat < 1 | carat > 5)


############### SLICE #####################


# slice - rows by row number
diamonds %>% slice(1:5)
diamondds %>% slice(c(1:5, 8, 15:20))
diamonds %>% slice(-1) # rows not to be returned


############## MUTATE #####################


# creating a new column
diamonds %>% mutate(price/carat)

# new column and view it
diamonds %>% select(carat, price) %>% mutate(price/carat)

# new column with name
diamonds %>% select(carat, price) %>% mutate(ratio=price/carat)

# two new colums in one mutate()
diamonds %>%
  select(carat, price) %>%
  mutate(ratio=price/carat, double=ratio*2)

# get column back into dataframe
library(magrittr)
diamonds2  <- diamonds
diamonds2 %<>% # %<>% - used for assignment
  select(carat, price) %>%
  mutate(ratio=price/carat, double=ratio*2)

%<>% # Assignment pipe
  # pipes left hand side into the function on right hand side
  # assigns result back to object on left hand side

# %<>% does not preclude assignment operator
diamonds2  <- diamonds2 %>%
  mutate(quadrupe=double*2)


############# SUMMARIZE #####################


# calculate mean of a column
summarize(diamonds, mean(price))
diamonds %>% summarize(mean(price))

# naming output and multiple outputs
diamonds %>%
  summarize(AvgPrice = mean(price),
            MedianPrice = median(price),
            AvgCarat = mean(carat))


############ GROUP BY #######################


# using column to segment calculations
diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price))

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price), SumCarat = sum(carat))

# grouping two variables
diamonds %>%
  group_by(cut, color) %>%
  summarize(AvgPrice = mean(price), SumCarat = sum(carat))


############ ARRANGE #########################


# using arrange to sort
diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price), SumCarat = sum(carat)) %>%
  arrange(AvgPrice) # arrange(desc(AvgPrice)) - for descending order


########### DO ########################


# create function and apply for analysis
topN  <- function(x, N=5) {
  x %>% arrange(desc(price)) %>% head(N)
}

diamonds %>% group_by(cut) %>% do(topN(.,N=3))
