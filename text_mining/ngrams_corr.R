# add token = "ngrams", n = num_gram -> unnest_tokens()
library(dplyr)
library(tidytext)
library(janeaustenr)

# create bigrams from Austen texts
austen.bigrams  <- austen_books() %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
austen.bigrams
# # A tibble: 725,049 x 2
#                   book          bigram
#                 <fctr>           <chr>
#  1 Sense & Sensibility       sense and
#  2 Sense & Sensibility and sensibility
#  3 Sense & Sensibility  sensibility by
#  4 Sense & Sensibility         by jane
#  5 Sense & Sensibility     jane austen
#  6 Sense & Sensibility     austen 1811
#  7 Sense & Sensibility    1811 chapter
#  8 Sense & Sensibility       chapter 1
#  9 Sense & Sensibility           1 the
# 10 Sense & Sensibility      the family
# # ... with 725,039 more rows


# most common bigrams
austen.bigrams %>%
  count(bigram, sort = TRUE)

# use separate() -> splits column into multiple based on delimiter
# split word column ->> word1 & word2 column
# filter out ones with stop word
library(tidyr)

bigrams.separated  <- austen.bigrams %>%
  separate(bigram, c('word1', 'word2'), sep = " ")

bigrams.filtered  <- bigrams.separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

# new bigram counts
bigram.counts  <- bigrams.filtered %>%
  count(word1, word2, sort = TRUE)
bigram.counts

# recombine columns -> one col
bigrams.united  <- bigrams.filtered %>%
  unite(bigram, word1, word2, sep = " ")
bigrams.united

# most interesting trigrams
austen_books() %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3) %>%
  separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word,
         !word3 %in% stop_words$word) %>%
  count(word1, word2, word3, sort = TRUE)

# most interesting streets -> analyzing bigrams
bigrams.filtered %>%
  filter(word2 == "street") %>%
  count(book, word1, sort = TRUE)

# AFINN lexicon for sentiment analysis, numeric sentiment score for each word
AFINN  <- get_sentiments("afinn")
AFINN

# look at most frequent words preceded by "not" & assoc w/ sentiment
jot.words  <- bigrams.separated %>%
  filter(word1 == "not") %>%
  inner_join(AFINN, by = c(word2 = "word")) %>%
  count(word2, score, sort = TRUE) %>%
  ungroup()
jot.words # suppose to be not.words

# which words were most influential in direction
library(ggplot2)

jot.words %>%
  mutate(contribution = n * score) %>%
  arrange(desc(abs(contribution))) %>%
  head(20) %>%
  mutate(word2 = reorder(word2, contribution)) %>%
  ggplot(aes(word2, n * score, fill = n * score > 0)) +
  geom_col(show.legend = FALSE) +
  xlab('Words preceded by \"not\"') +
  ylab('Sentiment score * number of occurrences') +
  coord_flip()

# Visualizing network of bigrams witha ggraph

# from: node edge is comfing from
# to: node egdge is going towards
# weight: numeric value associated with each edge


library(igraph)

# original counts
bigram.counts

# filter for only relatively common combinations
bigram.graph  <- bigram.counts %>%
  filter(n > 20) %>%
  graph_from_data_frame()
bigram.graph

# create word visualization
library(ggraph)
set.seed(2017)

ggraph(bigram.graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)

set.seed(2016)


## Get Bigrams & Graph Them

library(dplyr)
library(tidyr)
library(tidytext)
library(ggplot2)
library(igraph)
library(ggraph)

count.bigrams  <- function(dataset) {
  dataset %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
    separate(bigram, c('word1', 'word2'), sep = " ") %>%
    filter(!word1 %in% stop_words$word,
           !word2 %in% stop_words$word) %>%
    count(word1, word2, sort = TRUE)
}

visualize.bigrams  <- function(bigrams) {
  set.seed(2016)
  a  <- grid::arrow(type = "closed", length = unit(.15, "inches"))

  bigrams %>%
    graph_from_data_frame() %>%
    ggraph(layout = "fr") +
    geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = a) +
    geom_node_point(color = "lightblue", size = 5) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
    theme_void()
}


# Analyze King James Version of Bible
library(gutenbergr)
kjv  <- gutenberg_download(10)

kjv.bigrams  <- kjv %>%
  count.bigrams()

# filter out rare combos, as well as digits
kjv.bigrams %>%
  filter(n > 40,
         !str_detect(word1, "\\d"),
         !str_detect(word2, "\\d")) %>%
  visualize.bigrams()


###
# Counting & Correl Pairs of Words
###

# counting and correlating among sections
austen.section.words  <- austen_books() %>%
  filter(book == "Pride & Prejudice") %>%
  mutate(section = row_number() %/% 10) %>%
  filter(section > 0) %>%
  unnest_tokens(word, text) %>%
  filter(!word %in% stop_words$word)
austen.section.words

library(widyr)

# counts words co-occuring within sectiosns
word.pairs  <- austen.section.words %>%
  pairwise_count(word, section, sort = TRUE)
word.pairs

# words most often occur with Darcy
word.pairs %>%
  filter(item1 == "darcy")


###
# Pairwise Correlation
###

# widyr::pairwise_cor() -> phi coefficient
# filter for least relatively common words first
word.cors  <- austen.section.words %>%
  group_by(word) %>%
  filter(n() >= 20) %>%
  pairwise_cor(word, section, sort = TRUE)
word.cors

# words most correlated to 'pounds'
word.cors %>%
  filter(item1 == 'pounds')

word.cors %>%
  filter(item1 %in% c('elizabeth', 'pounds', 'married', 'pride')) %>%
  group_by(item1) %>%
  top_n(6) %>%
  ungroup() %>%
  mutate(item2 = reorder(item2, correlation)) %>%
  ggplot(aes(item2, correlation)) +
  geom_bar(stat = 'identity') +
  facet_wrap(~ item1, scales = 'free') +
  coord_flip()
