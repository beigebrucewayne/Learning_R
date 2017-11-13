library(V8)

# going to need V8 -> to press LOAD MORE button
# button CSS Selector -> .btn-default

library(rvest)
library(tidyverse)
library(jsonlite)
library(httr)
library(stringr)

# make GET request to link
# read response to HTML
link  <- "https://stockx.com/sneakers"
res  <- httr::GET(link)
sneaker_html  <- read_html(link)

# use CSS selector to grab sneaker Name + Price
# clean response
data  <- sneaker_html %>%
  html_nodes(".browse-tile") %>%
  html_text() %>%
  as_tibble() %>%
  rename(sneakers = value) %>%
  separate(col = sneakers, into = c("sneaker", "price"), sep = "LOWEST ASK")

# lowercase sneaker names
sneaker.names  <- str_to_lower(data$sneaker)

# add in cleaned column, select in order
data <- data %>%
  add_column(sneaker.names) %>%
  select(sneaker.names, price) %>%
  rename(sneaker = sneaker.names)

# strip $'s from price column
# change column from CHAR -> DBL
test[2]  <- lapply(test[2], function(x) as.numeric(gsub("[,$]", "", x)))

# testing dataset
test <- data
