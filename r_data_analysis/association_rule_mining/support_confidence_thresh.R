library(ggplot2)
library(arules)

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

# explore support and confidence space for transactions

explore.parameters  <- function(transactions) {

  support.values  <- seq(from = 0.001, to = 0.1, by = 0.001)
  confidence.values  <- seq(from = 0.05, to = 0.1, by = 0.01)
  support.confidence  <- expand.grid(support = support.values, confidence = confidence.values)

  # rules for various combos of support and confidence
  rules.grid  <- apply(support.confidence[,c('support', 'confidence')], 1, function(x) get.rules(x['support'], x['confidence'], transactions))

  no.rules  <- sapply(seq_along(rules.grid), function(i) length(labels(rules.grid[[i]])))

  no.rules.df  <- data.frame(support.confidence, no.rules)
  return(no.rules.df)
}

# plot numbers of rules generated for diff support and conf thresholds

get.plots  <- function(no.rules.df) {

  exp.plot  <- function(confidence.value) {
    print(ggplot(no.rules.df[no.rules.df$confidence == confidence.value,], aes(support, no.rules), environment = environment()) + geom_line() + ggtitle(paste("confidence = ", confidence.value)))
  }

  confidence.values  <- c(0.07, 0.08, 0.09, 0.1)
  mapply(exp.plot, confidence.value = confidence.values)
}

columns  <- c("order_id", "product_id")
data.path  <- "./data.csv"

transactions.obj  <- get.txn(data.path, columns)
no.rules.df  <- explore.parameters(transactions.obj)

head(no.rules.df)

get.plots(no.rules.df)
