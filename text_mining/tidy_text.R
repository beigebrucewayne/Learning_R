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

# remove stop words, 'the', 'of', 'to
data(stop_words)
tidy.books  <- tidy.books %>%
  anti_join(stop_words)

# most common words
tidy.books %>%
  count(word, sort = TRUE)

# most commons words graph
library(ggthemes)
library(ggplot2)
tidy.books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, color = word)) + 
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  theme_hc(bgcolor="darkunica") +
  scale_colour_hc("darkunica")


# Word Frequencies
library(gutenbergr)

hgwells  <- gutenberg_download(c(35, 36, 5230, 159))

tidy.hgwells  <- hgwells %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

# count of words
tidy.hgwells %>% count(word, sort = TRUE)

bronte  <- gutenberg_download(c(1260, 768, 969, 9182, 767))

tidy.bronte  <- bronte %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

tidy.bronte %>%
  count(word, sort = TRUE)


# Compare Frequencies across authors
library(tidyr)

frequency  <- bind_rows(mutate(tidy.bronte, author = "Bronte Sisters"),
                        mutate(tidy.hgwells, author = "H.G. Wells"),
                        mutate(tidy.books, author = "Jane Austen")) %>%
  # used to handle italics in certain text
  # _any_ == any, that's whats being accounted for
  mutate(word = str_extract(word, "[a-z']+")) %>%
  count(author, word) %>%
  group_by(author) %>%
  mutate(proportion = n / sum(n)) %>%
  select(-n) %>%
  spread(author, proportion) %>%
  gather(author, proportion, `Bronte Sisters`:`H.G. Wells`)

# visualizing the frequencies
library(scales)

ggplot(frequency, aes(x = proportion, y = `Jane Austen`, color = abs(`Jane Austen` - proportion))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "gray75") +
  facet_wrap(~author, ncol = 2) +
  theme(legend.position = "none") +
  labs(y = "Jane Austen", x = NULL)

# how similar are words of Austen & Bronte Sisters
likeness  <- cor.test(data = frequency[frequency$author == "Bronte Sisters",], ~ proportion + `Jane Austen`)
# similarity of Wells & Austen
likeness2  <- cor.test(data = frequency[frequency$author == "H.G. Wells",], ~ proportion + `Jane Austen`)
