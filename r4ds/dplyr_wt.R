### DPLYR VERBS


# select - return subset of columns
# filter - extract subset of rows from df based on logical conditions
# arrange - reorder rows of df
# rename - rename variables in df
# mutate - add new variables/columns to existing variables
# summarize - summary stats of different vars in df
# %>% - the pipe

library(dplyr)
library(tidyverse)

# basic structure of data
dim(iris)
str(iris)
iris <- as.tibble(iris)



### SELECT()

names(iris)
# selecting (df_name, columns to:from)
subset  <- select(iris, Sepal.Length:Petal.Width)
# omitting columns, negation
select(iris, -(Sepal.Length:Petal.Width))
head(subset)


# subsetting columns in Base R
i  <- match("Sepal.Length", names(iris))
j  <- match("Petal.Width", names(iris))
head(iris[, -(i:j)])


# every column that ends with h
column_h  <- select(iris, ends_with("h"))
str(column_h)
# every column starts with S
column_s  <- select(iris, starts_with("S"))
str(column_s)


### FILTER()


head(iris)
# # A tibble: 6 x 5
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#          <dbl>       <dbl>        <dbl>       <dbl>  <fctr>
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa

petal_greater_3  <- filter(iris, Petal.Length > 3)
min(petal_greater_3$Petal.Length)
# [1] 3.3

sepal_4_petal_3  <- filter(iris, Sepal.Length > 4 & Petal.Length > 3)
min(sepal_4_petal_3$Sepal.Length)
# [1] 4.9



### ARRANGE()


arr_petalwidth  <- arrange(iris, Petal.Width)
head(arr_petalwidth)
arr_petalwidth_desc  <- arrange(iris, desc(Petal.Width))


### RENAME()


iris  <- rename(iris, sepal_length = Sepal.Length, sepal_width = Sepal.Width)
head(iris, 2)


### MUTATE()


transmute() # mutate, but drops ALL non-transformed variables

iris %>%
  mutate(
         petal_width_detrend = Petal.Width - mean(Petal.Width, na.rm = TRUE),
         sepal_width_detrend = Sepal.Width - mean(Sepal.Width, na.rm = TRUE))


### GROUP_BY()


species  <- group_by(iris, Species)
summarize(species, sl = mean(sepal_length, na.rm = TRUE), sw = mean(sepal_width, na.rm = TRUE), pl = mean(Petal.Length, na.rm = TRUE))
