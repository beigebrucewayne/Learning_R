library(rtweet)
library(ggthemes)
library(tidyverse)
library(tidytext)

goatapp <- search_tweets("@goatapp", n = 12000, include_rts = FALSE)

gdf <- read_csv("./rTweet/goatapp_tweets.csv")
# clean out levels
goat_df <- data.frame(lapply(goatapp, as.character), stringsAsFactors = FALSE)

goatapp_text <- goat_df$text
goatapp_text <- as.tibble(goatapp_text)

# basic counts
word_count <- goatapp_text %>%
  unnest_tokens(word, value) %>%
	count(word, sort = TRUE) %>%
	filter(!word == "goatapp") %>%
	anti_join(stop_words)

word_count %>%
  filter(n > 10) %>%
  mutate(word = reorder(word, n)) %>%
  top_n(25) %>%
  ggplot(aes(word, n)) +
  geom_col(aes(fill = "darkunica"), show.legend = FALSE) +
  labs(title = "Top 25 Most Used Words",
       subtitle = "Not including stop words (the, to, a, etc..)",
       y = "count") +
  theme_hc(bgcolor = "darkunica") +
  scale_fill_hc("darkunica") +
  theme(axis.text.y = element_text(colour = '#FFFFFF'),
        panel.grid.major.y = element_line(colour = '#2A2A2B')) +
  coord_flip()
