# basic string creation
string1  <- "This is a string"

# escaping string
double_quote  <- "\""

# character vector
c("one", "two", "three")

# length of string
str_length(c("a", "R for data science"))

# combining strings
str_c("x", "y") # -> "xy"
str_c("x", "y", sep = ",")

# collapse vector into single string
str_c(c("x", "y", "z"), collapse = ", ") # "x, y, z"

# subsetting strings
x  <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3) # "ple" "ana" "ear"

str_sub(x, 1, 1)  <- str_to_lower(str_sub(x, 1, 1))

# Locales
str_to_lower()
str_to_upper()
str_to_title()
str_wrap() # wrap strings into nicely formatted paragraphs
str_trim() # remove whitespace str_trim(string, side = c("both", "left", "right"))

# sorting
x  <- c("apple", "eggplant", "banana")
str_sort(x, locale = "en") # english
str_sort(x, locale = "haw") # hawaiian

# using regex
str_view()
str_view_all() # take character vector and regex, show how they match

x  <- c("apple", "banana", "pear")
str_view(x, "an") # match exact string containing "an"
str_view(x, ".a.") # match any character except newline -> "ban" "ear"

# match start/end of string
# ^ - match start
# $ - match end
x  <- c("apple", "banana")
str_view(x, "^a") # matches first a in apple
str_view(x, "a$") # matches last a in banana

# detect matches - char vector matches pattern
x  <- c("dog", "animal")
str_detect(x, "d") # TRUE FALSE

# how many words start with t
sum(str_detect(words, "^t"))

# what proportion of common words end with a vowel?
sum(str_detect(words, "[aeiou]$"))

# find all words containing at least one vowel, and negate
no_vowels  <- !str_detect(words, "[aeiou]")

# find all words consisting only of consonants
no_vowels2  <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels, no_vowels2)

# select elements that match a pattern
words[str_detect(words, "x$")]
str_subset(words, "x$")

# how many matches of a string
x  <- c("ding", "dong")
str_count(x, "d") # 1 1

# on avg how many vowels per word
mean(str_count(words, "[aeiou]"))

# using str_count() to create new columns
df %>%
    mutate(
        vowels = str_count(word, "[aeiou]"),
        consonants = str_count(word, "[^aeiou]")
)

# find all sentences that contain a color
colors  <- c("red", "orange", "yellow", "green", "blue", "purple")
color_match  <- str_c(colors, collapse = "|") # "red|orange|yellow|green|blue|purple"
has_color  <- str_subset(sentences, color_match)
matches  <- str_extract(has_color, color_match)
more  <- sentences[str_count(sentences, color_match > 1)]
str_view_all(more, color_match)
str_extract(more, color_match)
str_extract_all(more, color_match)

# simplify = TRUE -> returns matrix
str_extract_all(more, color_match, simplify = TRUE)

# finding nouns in a sentence
noun  <- "(a|the) ([^ ]+)"
has_noun  <- sentences %>%
    str_subset(noun) %>%
    head(10)
has_noun %>%
    str_extract(noun)

# returns matrix
has_noun %>%
    str_match(noun)

# replacing matches

str_replace()
str_replace_all()

# replace pattern with fixed string
x  <- c("lebron", "kyrie")
str_replace(x, "[aeiou]", "=") # l=nr=n
str_replace_all(x, "[aeiou]", "-")

# multiple replacements using named vector
x  <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

# splitting

str_split()

sentences %>%
    str_split(" ") # turn sentence -> words

# specifiy max number of pieces
fields  <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>%
    str_split(": ", n = 2, simplify = TRUE)

# split using boundary()
x  <- "This is a sentence. This is another sentence."
str_view_all(x, boundary(word)) # options: character, line, sentence, word
