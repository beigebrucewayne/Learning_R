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


