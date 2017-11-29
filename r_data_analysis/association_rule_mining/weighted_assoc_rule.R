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

# plot network graph
plot.graph  <- function(cross.sell.rules) {

  edges  <- unlist(lapply(cross.sell.rules['rules'], strsplit, split='=>'))

  g  <- graph(edges = edges)

  plot(g)
}

columns  <- c("order_id", "product_id")
data.path  <- "./data.csv"

transactions.obj  <- get.txn(data.path, columns)

# update transactions objects w/ weights
transactions.obj@itemsetInfo$weight  <- NULL

# read weights file
weights  <- read.csv("./weights.csv")
transactions.obj@itemsetInfo  <- weights

# frequent item set generation
support  <- 0.01

parameters  <- list(
	support = support,
	minlen = 2,
	maxlen = 10,
	target = "frequent itemsets")

weclat.itemsets  <- weclat(transactions.obj, parameter = parameters)

weclat.itemsets.df  <- data.frame(weclat.itemsets = labels(weclat.itemsets), weclat.itemsets@quality)

head(weclat.itemsets.df)
tail(weclat.itemsets.df)

# rule introduction
weclat.rules  <- ruleInduction(weclat.itemsets, transactions.obj, confidence = 0.3)
weclat.rules.df  <- data.frame(rules = labels(weclat.rules), weclat.rules@quality)
head(weclat.rules.df)

weclat.rules.df$rules  <- as.character(weclat.rules.df$rules)

plot.graph(weclat.rules.df)
