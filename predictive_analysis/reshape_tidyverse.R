sportLeague  <- tibble(sport=c("hockey", "baseball", "football"),
                       league=c("NHL", "MLB", "NFL"))
trophy  <- tibble(trophy=c("Stanley Cup", "Comissioner's Trophy", "Vince Lombardi Trophy"))

# combine 2 tibbles -> 1 tibble
trophies1  <- bind_cols(sportLeague, trophy)

# build another tibble using tribble (row-wise creation)
trophies2  <- tribble(
  ~sport, ~league, ~trophy,
  "Basketball", "NBA", "Larry O'Brien Trophy",
  "Golf", "PGA", "Wanamaker Trophy")

# combine into tibble
trophies  <- bind_rows(trophies1, trophies2)
trophies

# joins w/ dplyr
left_join()
right_join()
inner_join()
full_join()
semi_join()
anti_join()

# using joins
library(readr)
colorsURL  <- 'http://www.jaredlander.com/data/DiamondColors.csv'
diamondColors  <- read_csv(colorsURL)
diamondColors

# using diamonds data
diamonds
unique(diamonds$color)

# join two datasets
left_join(diamonds, diamondColors, by=c('color'='Color'))
distinct(color, Description)

# right_join()
right_join(diamonds, diamondColors, by=c('color'='Color')) %>% nrow

# inner_join() - rows from both tables with matching keys
all.equal(
  left_join(diamonds, diamondColors, by=c('color'='Color')),
  inner_join(diamonds, diamondColors, by=c('color'='Color'))
)

# full_join() - (outer) return rows of both tables, even if no match
# semi_join() - returns first rows in left-hand table that have matches in right-hand table
semi_join(diamondColors, diamonds, by=c('Color'='color'))

# anti_join() - opp of semi_join() - returns rows of left-hand table not matched in rows of right-hand table
anti_join(diamondColors, diamonds, by=c('Color'='color'))

# same as above
diamondColors %>% filter(Color %in% unique(diamonds$color))
diamondColors %>% filter(!Color %in% unique(diamonds$color))

emotion  <- read_tsv('http://www.jaredlander.com/data/reaction.txt')
emotion %>% gather(key=Type, value=Measurement, Age, BMI, React, Regulate)

emotionLong  <- emotion %>%
  gather(key=Type, value=Measurement, Age, BMI, React, Regulate) %>%
  arrange(ID)
head(emotionLong, 20)

# specifying columns we don't want to pivot
emotion %>% gather(key=Type, value=Measurement, -ID, -Test, -Gender)

# spread() - makes data wide; key = column -> new column names; value = column holds values to populate new columns
emotionLong %>% spread(key=Type, value=Measurement)
