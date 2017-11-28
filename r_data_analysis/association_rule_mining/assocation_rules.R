# market basket analysis

# apriori algo
  # Measures -> Support + Confidence

  # 1 -> finds transaction frequency of all individual items
    # support -> value between 0 - 1, frequent if appears in percent
  # 2 -> Confidence | A => B, P ( B | A )
    # rule: A => B, induced from <A, B>
    # support: <A, B>, # of transactions where A and B occur divided by total # of transactions

library(tidyverse)
library(arules)

data.path  <- "./data.csv"

data  <- read_csv(data.path)

head(data)

unique.orders  <- data %>%
  group_by("order_id") %>%
  summarize(order.count = n_distinct(order_id))

unique.products  <- data %>%
  group_by("product_id") %>%
  summarize(product.count = n_distinct(product_id))

transactions.obj  <- read.transactions(
  file = data.path,
  format = "single",
  sep = ",",
  cols = c("order_id", "product_id"),
  rm.duplicates = FALSE,
  quote = "",
  skip = 0,
  encoding = "unkown")

most.frequent  <- data.frame(sort(itemFrequency(transactions.obj, type = "absolute"), decreasing = TRUE))
colnames(most.frequent) <- "most.frequentItems"

least.frequent  <- data.frame(sort(itemFrequency(transactions.obj, type = "absolute"), decreasing = FALSE))
colnames(least.frequent) <- "least.frequentItems"

itemFrequencyPlot(transactions.obj, topN = 25)

# Phase One => Support

support  <- 0.01

parameters  <- list(
  support = support,
  minlen = 2, # min num of items per item set
  maxlen = 10,  # max num of items per item set
  target = "frequent itemsets")

freq.items  <- apriori(transactions.obj, parameter = parameters)

str(freq.items)

freq.items.df  <- data.frame(item_set = labels(freq.items), support = freq.items@quality)

head(freq.items.df)
tail(freq.items.df)

# ignore high freq itemsets
exclusion.items  <- c('Banana', 'Bag of Organic Bananas')
freq.items  <- apriori(transactions.obj,
  parameter = parameters,
  appearance = list(none = exclusion.items,
                    default = "both"))

freq.items.df  <- data.frame(item_set = labels(freq.items), support = freq.items@quality)

head(freq.items.df, 10)

# Phase Two => Confidence

confidence  <- 0.4 # Interest Measure

params = list(
  support = support,
  confidence = confidence,
  minlen = 2,
  maxlen = 10,
  target = "rules")

rules  <- apriori(transactions.obj, parameter = params)
rules.df  <- data.frame(rules = labels(rules), rules@quality)

# lift -> how many times A and B occur together
  # lift > 1, considered to be more effective

interestMeasure(rules, transactions = transactions.obj)

rules.df  <- cbind(rules.df, data.frame(interestMeasure(rules, transactions = transactions.obj)))

is.redundant(rules) # any redudant rules
duplicated(rules) # any duplicate rules

is.significant(rules, transactions.obj, method = "fisher")
is.significant(rules, transactions.obj, method = "chisq")

# list of transactions -> where rules apply
as(supportingTransactions(rules, transactions.obj), "list")
