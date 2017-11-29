library(arules)
library(arulesViz)

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

get.rules  <- function(support, confidence, transactions) {

  parameters <- list(
    support = support,
    confidence = confidence,
    minlen = 2,
    maxlen = 10,
    target = "rules")

  rules  <- apriori(transactions, parameter = parameters)

  return(rules)
}

support  <- 0.01
confidence  <- 0.2
columns  <- c("order_id", "product_id")
data.path  <- "./data.csv"
transactions.obj  <- get.txn(data.path, columns)

# induce rules
all.rules  <- get.rules(support, confidence, transactions.obj)

# scatter plot fo rules
plotly_arules(all.rules, method = "scatterplot", measure = c("support", "lift"), shading = "order")

# interactive scatter plots
plot(all.rules, method = NULL, measure = "support", shading = "lift", engine = "interactive")
# top rules by lift
sub.rules  <- head(sort(all.rules, by="lift"), 15)

# group plot of rules
plot(sub.rules, method = "grouped")

# graph plot fo rule
plot(sub.rules, method = "graph", measure = "lift")
