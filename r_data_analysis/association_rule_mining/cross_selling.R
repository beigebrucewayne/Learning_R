library(arules)
library(igraph)

# get transaction object from given data file

get.txn  <- function(data.path, columns) {

  transactions.obj  <- read.transactions(
    file = data.path,
    format = "single",
    sep = ",",
    cols = columns,
    rm.duplicates = FALSE,
    quote = "",
    skip = 0,
    encoding = "unknown")

  return(transactions.obj)
}

# get apriori rules for given support and confidence values

get.rules  <- function(support, confidence, transactions) {

  parameters = list(
    support = support,
    confidence = confidence,
    minlen = 2,
    maxlen = 10,
    target = "rules")

  rules  <- apriori(transactions, parameter = parameters)

  return(rules)
}

# generate and prune rules for given support / conf values

find.rules  <- function(transactions, support, confidence, topN = 10) {

  # get rules for given combo
  all.rules  <- get.rules(support, confidence, transactions)

  rules.df  <- data.frame(rules = labels(all.rules), all.rules@quality)

  other.im  <- interestMeasure(all.rules, transactions = transactions)

  rules.df  <- cbind(rules.df, other.im[,c('conviction', 'leverage')])

  # keep best rules based on IM
  best.rules.df  <- head(rules.df[order(-rules.df$leverage),], topN)

  return(best.rules.df)
}

# plot associated items as graph

plot.graph  <- function(cross.sell.rules) {

  edges  <- unlist(lapply(cross.sell.rules['rules'], strsplit, split='=>'))

  g  <- graph(edges = edges)

  plot(g)
}

# inputs

support  <- 0.01
confidence  <- 0.2
columns  <- c("order_id", "product_id")
data.path  <- "./data.csv"
transactions.obj  <- get.txn(data.path, columns)

# leverage -> how many more sales if sold together
# conviction -> direction of rule
cross.sell.rules  <- find.rules(transactions.obj, support, confidence)
cross.sell.rules$rules  <- as.character(cross.sell.rules$rules)

plot.graph(cross.sell.rules)
