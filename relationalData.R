# Mutating Joins - add new vars to dataframe from matching obs in another
# Filtering Joins - filter obs from dataframe based on whether they match obs in a different table
# Set Operations - treats obs as if they were set elements

# 4 tibbles in flights dataset
# airlines, airports, planes, weather

# Primary Key - uniquely identifies obs in own table
# Foriegn Key - uniquely identifies obs in another table



# Finding primary keys - has to uniquely identify
# fitler to see if obs occurs more than once
planes %>%
    count(tailnum)
    filter(n > 1)

weather %>%
    count(year, month, day, hour, origin) %>%
    filter(n > 1)

# adding a primary key if table is missing one
# use mutate() & row_number()
# Surrogate Key ^

# Relation = primary key + foreign key (another table)
# typically 1 -> many


###### MUTATING JOINS #########

# combine variables from two tables

# create a narrow dataset to see what is going on
flights2  <- flights %>%
    select(year:day, hour, origin, dest, tailnum, carrier)

# add full airline name
# combine airlines (table) + flights2 dataframes with left_join()
flights2 %>%
    select(-origin, -dest) %>%
    left_join(airlines, by = "carrier")

# same thing - using mutate & base R subset
flights2 %>%
    select(-origin, -dest) %>%
    mutate(name = airlines$name[match(carrier, airlines$carrier)])

# inner join - excludes rows that are unmatched ( not ideal )
x %>%
    inner_join(y, by = "key")

# outer joins - keeps obs appear in at least one table

# 3 types of outer joins
# left_join() - keeps all obs in x
# right_join() - keeps all obs in y
# full_join() - keeps alls obsin x and y


#### USING BASE R = DPLYR ######

inner_join(x, y) -> merge(x, y)
left_join(x, y) -> merge(x, y, all.x = TRUE)
right_join(x, y) -> merge(x, y, all.y = TRUE)
full_join(x, y) -> merge(x, y, all.x = TRUE, all.y = TRUE)

##### SQL EQUIVALENTS ##########

inner_join(x, y, by = "z") -> SELECT * FROM x INNER JOIN y USING (z)
left_join(x, y, by = "z") -> SELECT * FROM x LEFT OUTER JOIN y USING (z)
right_join(x, y, by = "z") -> SELECT * FROM x RIGHT OUTER JOIN y USING (z)
full_join(x, y, by = "z") -> SELECT * FROM x FULL OUTER JOIN y USING (z)


##### FILTERING JOINS ##########

semi_join(x, y) # keeps all obs in x that have match y
anti_join(x, y) # drops all obs in x that have match y

# found top 10 most popular destination
top_dest  <- flights %>%
    count(dest, sort = TRUE) %>%
    head(10)

# find each flight that went to one of destinations
flights %>%
    filter(dest %in% top_dest$dest)

# semi_join() - connects two tables
# instead of adding columns - keeps rows in x that have match in y
flights %>%
    semi_join(top_dest)

###### SET OPERATIONS ##########

intersect(x, y) # return only obs in both x and y
union(x, y) # return unique obs in x and y
setdiff(x, y) # return obs in x != y
