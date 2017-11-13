library(V8)
library(rvest)
library(tidyverse)
library(jsonlite)
library(httr)

link  <- "https://stockx.com/sneakers"
res  <- httr::GET(link)

#text  <- httr::content(res, "text")
sneaker_html  <- read_html(link)

data  <- sneaker_html %>%
  html_nodes(".browse-tile") %>%
  html_text()

data  <- data %>%
  as_tibble() %>%
  rename(Sneakers = value) %>%
  separate(col = Sneakers, into = c("sneaker", "price"), sep = "LOWEST ASK")

test <- data
