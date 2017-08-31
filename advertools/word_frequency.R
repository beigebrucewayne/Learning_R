library(advertools)

df  <- data.frame(text = c("first word", "second word", "third word"), metric=1)
# metric=1, just frequency count - no weights
df

# kw_match_type()

carnames  <- data.frame(broad = rownames(mtcars))
head(carnames$modified)
carnames$modified  <- kw_modified_broad(carnames$broad)
carnames$phrase  <- kw_phrase(carnames$broad)
carnames$exact  <- kw_exact(carnames$phrase)
carnames$negative  <- kw_negative(carnames$exact)
carnames[1:10,]
library(tidyverse)
cars_kw  <- as.tibble(carnames)
head(cars_kw)

library(readr)
write_csv(cars_kw, "/Users/bastcastle/Desktop/cars.csv")

kw_combos  <- kw_combinations(mtcars, c("cyl", "mpg"))
head(kw_combos)
head(iris)
kw_combo  <- kw_combinations(iris, c("Species"))
head(diamonds)
kw_combos  <- kw_combinations(diamonds, c("cut", "clarity", "color"))
head(kw_combos)
kw_d  <- kw_combos %>% select('cut_clarity_color')
unique(kw_d)
write_csv(kw_d, "/Users/bastcastle/Desktop/kw_d.csv")
sneaks  <- search_ads_google(c("yeezy sneakers", "yeezy boost", "yeezy boost 350", "yeezy powerphase"))
write_csv(sneaks, "/Users/bastcastle/Desktop/sneaks.csv")

