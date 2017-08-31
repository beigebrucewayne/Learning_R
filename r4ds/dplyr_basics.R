# 5 dplyr basics
# filter() - pick obs by their value
# arrange() - reorder rows
# select() - pick variables by name
# mutate() - create new var with functions of existing vars
# summarize() - collapse many values into one summary


######### FILTER #####################


# first object - dataframe
# second object - expressions that filter dataframe
filter(flights, month == 1, day == 1)

# saving result
jan1  <- filter(flights, month == 1, day == 1)

# printing results & saving results
(dec25  <- filter(flights, month == 12, day == 25))

# alternate | (or)
nov_dec  <- filter(flights, month %in% c(11, 12))

# filtering and preserving NA values
filter(df, is.na(x) | x > 1)


########### ARRANGE ####################


arrange(flights, year, month, day) # arrange by year, then use next columns for tie break

# reorder by column in descending order
arrange(flights, desc(arr_delay))


########## SELECT ######################


# select a subset of columns (variables)
select(flights, year, month, day)

# select all columns between two columns
select(flights, year:day)

# select all columns except
select(flights, -(year:day))

# helper functions
starts_with("abc")
ends_with("xyz")
contains("ijk")
matches("(.)\\1") #select var match regex
num_range("x", 1:3) # matches x1, x2, x3

# rename a column
rename(flights, tail_num = tailnum)


############ MUTATE ######################


flights_sml  <- select(flights, year:day, ends_with("delay"), distance, air_time)

# adding additional columns
mutate(flights_sml, gain = arr_delay - dep_delay, speed = distance / air_time * 60)

# only want to keep new variables - use transmute()
transmute()


########### SUMMARIZE ####################


# collapses dataframe into single row
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

# most effective when used with group_by()
by_day  <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

# using the pipe operator: %>%
delays <- flights %>% group_by(dest) %>% summarize(count = n(), dist = mean(distance, na.rm = TRUE), delay = mean(arr_delay, na.rm = TRUE)) %>% filter(count > 20, dest != "HNL")

# using na.rm to remove missing values
flights %>% group_by(year, month, day) %>% summarize(mean = mean(dep_delay, na.rm = TRUE))

# saving dataset w/o missing values
not_cancelled  <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))

# using count to check data
delays  <- not_cancelled %>%
    group_by(tailnum) %>%
    summarize(
        delay = mean(arr_delay, na.rm = TRUE),
        n = n()
    )

ggplot(data = delays, mapping = aes(x = n, y = delay)) +
    geom_point(alpha = 1/10)

# graphing batting average
batting  <- as_tibble(Lahman::Batting)

batters  <- batting %>%
    group_by(playerID) %>%
    summarize(
        ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
        ab = sum(AB, na.rm = TRUE)
    )

batters %>%
    filter(ab > 100) %>%
    ggplot(mapping = aes(x = ab, y = ba)) + geom_point() + geom_smooth(se = FALSE)

# standard deviation
not_cancelled %>%
    group_by(dest) %>%
    summarize(distance_sd = sd(distance)) %>%
    arrange(desc(distance_sd))

# count number of non missing values
sum(!is.na(x))

# count number of distinct values
n_distinct(x)

# dplyr includes count() function
not_cancelled %>%
    count(dest)

# grouping multiple variables
daily  <- group_by(flights, year, month, day)
(per_day  <- summarize(daily, flights = n()))
(per_month  <- summarize(per_day, flights = sum(flights)))
(per_year  <- summarize(per_month, flights = sum(flights)))
