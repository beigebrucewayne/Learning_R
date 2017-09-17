# tf-idf -> inverse document frequency
# ln * ( ndocuments / ndocuments containing term )


###
# Term Frequency in Jane Austen's novels
###

library(dplyr)
library(janeaustenr)
library(tidytext)

book.words  <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE) %>%
  ungroup()


total.words  <- book.words %>%
  group_by(book) %>%
  summarize(total = sum(n))

book.words  <- left_join(book.words, total.words)

book.words

# look at: n/total -> term frequency
library(ggplot2)

ggplot(book.words, aes(n/total, fill = book)) +
  geom_histogram(show.legend = FALSE) +
  xlim(NA, 0.0009) +
  facet_wrap(~book, ncol = 2, scales = 'free_y')

# Zipf's law -> frequency that a word appears is inversely proportional to
# its rank

freq_by_rank  <- book.words %>%
  group_by(book) %>%
  mutate(rank = row_number(), `term frquency` = n/total)
freq_by_rank


# visualizing Zipf's  law
# x = rank, y = term frequency

freq_by_rank %>%
  ggplot(aes(rank, `term frquency`, color = book)) +
  geom_line(size = 1.2, alpha = 0.8) +
  scale_x_log10() +
  scale_y_log10()


rank_subset  <- freq_by_rank %>%
  filter(rank < 500,
         rank > 10)

lm(log10(`term frquency`) ~ log10(rank), data = rank_subset)
# 
# Call:
# lm(formula = log10(`term frquency`) ~ log10(rank), data = rank_subset)
# 
# Coefficients:
# (Intercept)  log10(rank)  
#     -0.6226      -1.1125  
# 

# classic version of Zipf's law
# frequency alpha ( 1 / rank )

freq_by_rank %>%
  ggplot(aes(rank, `term frquency`), color = book) +
  geom_abline(intercept = -0.62, slope = -1.1, color = "gray50", linetype = 2) +
  geom_line(size = 1.2, alpha = 0.8) +
  scale_x_log10() +
  scale_y_log10()


# bind_tf_idf()

book.words  <- book.words %>%
  bind_tf_idf(word, book, n)
book.words

book.words %>%
  select(-total) %>%
  arrange(desc(tf_idf))

plot.austen  <- book.words %>%
  arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

plot.austen %>%
  top_n(20) %>%
  ggplot(aes(word, tf_idf, fill = book)) +
  geom_col() +
  labs(x = NULL, y = 'tf_idf') +
  coord_flip()

# look at each novel individually

plot.austen %>%
  group_by(book) %>%
  top_n(15) %>%
  ungroup %>%
  ggplot(aes(word, tf_idf, fill = book)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf_idf") +
  facet_wrap(~book, ncol = 2, scales = "free") +
  coord_flip()


###
# Analyzing Physics Text
###


library(gutenbergr)
physics  <- gutenberg_download(c(37729, 14725, 13476, 5001), meta_fields = "author")

# unnest_tokens -> tidy text, count how many times each word is used in each
# text
physics.words  <- physics %>%
  unnest_tokens(word, text) %>%
  count(author, word, sort = TRUE) %>%
  ungroup()
physics.words

# count tf-idf
physics.words  <- physics.words %>%
  bind_tf_idf(word, author, n)

plot.physics  <- physics.words %>%
  arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>%
  mutate(author = factor(author, levels = c("Galilei, Galileo",
                                            "Huygens, Christiaan",
                                            "Tesla, Nikola",
                                            "Einstein, Albert")))

plot.physics %>%
  top_n(20) %>%
  ggplot(aes(word, tf_idf, fill = author)) +
  geom_col() +
  labs(x = NULL, y = "tf-idf") +
  coord_flip()

# looking at each text individually
plot.physics %>%
  group_by(author) %>%
  top_n(15, tf_idf) %>%
  ungroup() %>%
  mutate(word = reorder(word, tf_idf)) %>%
  ggplot(aes(word, tf_idf, fill = author)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~author, ncol = 2, scales = "free") +
  coord_flip()

# observe 'eq' in Einstein texts
library(stringr)

physics %>%
  filter(str_detect(text, "eq\\.")) %>%
  select(text)
# eq = name of equations, should be cleaned out
# K1 also appears to be coordinate system, should be cleaned
physics %>%
  filter(str_detect(text, "K1")) %>%
  select(text)

# make custom list of stop_words -> more meaningful top words
# custom list + anti_join() to remove them
mystopwords  <- data_frame(word = c("eq", "co", "rc", "ac", "ak", "bn", "fig", "file", "cg", "cb", "cm"))

physics.words  <- anti_join(physics.words, mystopwords, by = "word")
plot.physics  <- physics.words %>%
  arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>%
  group_by(author) %>%
  top_n(15, tf_idf) %>%
  ungroup %>%
  mutate(author = factor(author, levels = c("Galilei, Galileo",
                                            "Huygens, Christiaan",
                                            "Tesla, Nikola",
                                            "Einstein, Albert")))

ggplot(plot.physics, aes(word, tf_idf, fill = author)) +
  geom_col(show.legend = FALSE) +
  labs(x =  NULL, y = "tf-idf") +
  facet_wrap(~author, ncol = 2, scales = "free") +
  coord_flip()
