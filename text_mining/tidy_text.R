# tidy data

# eavh variable is a column
# each obs is a row
# each type of observational unit is a table

# tidy text - table with one-token-per-row


# unnest_function()

text  <- c("Because I could no stop for Death -",
           "He kindly stopped for me -",
           "The Carriage held but just Ourselves -",
           "and Immortality")

# turn into tidy data -> dataframe
library(dplyr)
text_df  <- data_frame(line = 1:4, text = text)

# tidy tokens -> unnest func
library(tidytext)
text_df %>%
  unnest_tokens(word, text)

# tidying the works of Jane Austen
library(janeaustenr)
library(stringr)

original.books  <- austen_books() %>%
  group_by(book) %>%
  # group by book
  # assign linenumber to reference later
  mutate(linenumber = row_number(),
    # add chapter using regex
    chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
    ignore_case = TRUE)))) %>%
  ungroup()
original.books

# change -> tidy (one-token-per-row)
tidy.books  <- original.books %>%
  unnest_tokens(word, text)
