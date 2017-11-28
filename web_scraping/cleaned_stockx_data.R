library(rvest)
library(tidyverse)
library(stringr)

# make GET request to link
# read response -> HTML
link  <- "https://stockx.com/sneakers"
sneaker_html  <- read_html(link)

# CSS selector -> grab name + price
data  <- sneaker_html %>%
  html_nodes(".browse-tile") %>%
  html_text()

data  <- gsub("LOWEST ASK", " ", data)

df <- as.data.frame(data)
colnames(df) <- "Sneakers"

# strings -> pulling as factors
# convert variables -> "characters" while keeping df
# SO: https://stackoverflow.com/questions/2851015/convert-data-frame-columns-from-factors-to-characters
df[]  <- lapply(df, as.character)

sneaker.vector  <- as.vector(df$Sneakers)
