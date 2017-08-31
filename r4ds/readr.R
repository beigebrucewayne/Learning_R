read_csv() # csv files
read_csv2() # reads semicolon
read_tsv() # tab delimited
read_delim() # reads files with an delim
read_fwf() # reads fixed-width files
read_table() # reads fwf with column separated by white space


# basic reading in a file
heights  <- read_csv("path/to/file.csv")

# use col_names = FALSE, to turn off column headers -- defaults to X1, X2, etc..
read_csv("1,2,3\n4,5,6", col_names = FALSE)

# na to represent missing values
read_csv("a,b,c\n1,2,.", na = ".")

########## PARSERS #############

parse_logical()
parse_integer()
parse_double()
parse_number()
parse_character()
parse_factor() # creates factors, R data structure for categorical variables
parse_datetime()
parse_date()
parse_time()

# addressing different number mark
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))

# parse_number() effective at dealing with percents and currencies
parse_number("$100")
parse_number("20%")

# specify encoding
parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))

# figure out encoding
guess_encoding(charToRow(x1))

# factors used to parse known values
fruit <- c("apple", "banana")
parse_factor(c("apple","banana","banananan"), levels = fruit)

# specifying column data type
challenge  <- read_csv(readr_example("challenge.csv"), col_types = cols(x = col_double(), y = col_date()))

# read in all columns as character vectors
challenge2  <- read_csv(readr_example("challenge.csv"), col_types = cols(.default = col_character()))

# writing to a file
write_csv()
write_tsv()

# export CSV to Excel
write_excel_csv()

# write_csv() arguments - datafame, filename
write_csv(challenge, "challenge.csv")
