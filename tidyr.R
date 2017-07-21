# 3 Rules of Tidy Data

# 1. Each dataset in a tibble
# 2. Each variable in a column
# 3. Value are in cells

# gather() - fixing column names not variables
table4a %>%
    gather(`1999`, `2000`, key = "year", value = "cases")

# combining cleaned data
tidy4a  <- table4a %>%
    gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b  <- table4b %>%
    gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

# using spread to rearrange row -> column
spread(table2, key = type, value = count)

# gather() - makes wide tables narrow/longer
# spread() - makes long tables shorter/wider

# split column with two variabeles in one
table3 %>%
    separate(rate, into = c("cases", "population"))

# use a specific character to split column
table3 %>%
    separate(rate, into = c("cases", "population"), sep = "/")

# convert separate columns to better types
table3 %>%
    separate(rate, into = c("cases", "population"), convert = TRUE)

# untie() - combienes multiple columns into a single column
table5 %>%
    unite(new, century, year, sep = "")

# misssing values

# explicit: flagged with NA
# implicit: simply not present in data

stocks  <- tibble(
    year = c(2015, 2014),
    qtr = c(1, 2, 3),
    return = c(1.88, 0.49, NA)
)

# first year value missing (implicit)
# return has NA value (explicit)


# fixing explicit missing values
stocks %>%
    spread(year, return) %>%
    gather(year, return, `2015`:`2016`, na.rm = TRUE)

# fill - will fill in missing values with last non-missing value
treatment %>%
    fill(person)


############# TIDYR CASE STUDY ##################


who # internal tidyr datatset

# gather together columns that are not variables
who1  <- who %>%
    gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

# counting instances of new column
who1 %>%
    count(key)

# fix newrel -> new_rel to match rest of strings within column
who2  <- who1 %>%
    mutate(key = string::str_replace(key, "newrel", "new_rel"))

# split column into three unique columns
who3  <- who2 %>%
    separate(key, c("new", "type", "sexage"), sep = "_")

# drop new column since all data points are new
# also drop iso2 and iso3
who4  <- who3 %>%
    select(-new, -iso2, -iso3)

# separate sexage -> sex and age column
who5  <- who4 %>%
    separate(sexage, c("sex", "age"), sep = 1)


# complex pipe
who %>%
    gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
    mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
    separate(code, c("new", "var", "seaxage")) %>%
    select(-new, -iso2, -iso3) %>%
    separate(sexage, c("sex", "age"), sep = 1)
