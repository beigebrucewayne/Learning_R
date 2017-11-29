# creating weights for transactions w/ no prior weights

# HITS -> hyperlink-induced topic search
	# rate web pages
		# Hubs -> large number of out degrees
		# Authority -> large number of in degrees

# hubs -> transactions
# authorities -> products

source('./weighted_assoc_rule.R')

weights.vector  <- hits(transactions.obj, type = "relative")
weights.df  <- data.frame(transactionID = labels(weights.vector), weight = weights.vector)

# hits algo process

	# 1. authority node score update -> modify auth score of each node to sum of hub scores of each node that points to it
	# 2. hub node score update -> change hub score, sum of auth socres of each node that it points to
	# 3. normalize hub and auth scores -> continue unti hub and auth normalize

transactions.obj@itemsetInfo  <- weights.df

support  <- 0.01

parameters  <- list(
	support = support,
	minlen = 2,
	maxlen = 10,
	target = "frequent itemsets")

weclat.itemsets  <- weclat(transactions.obj, parameter = parameters)
weclat.itemsets.df  <- data.frame(weclat.itemsets = labels(weclat.itemsets), weclat.itemsets@quality)

weclat.rules  <- ruleInduction(weclat.itemsets, transactions.obj, confidence = 0.1)
weclat.rules.df  <- data.frame(weclat.rules = labels(weclat.rules), weclat.rules@quality)

head(weclat.rules.df)
tail(weclat.rules.df)

freq.weights  <- head(sort(itemFrequency(transactions.obj, weighted = TRUE), decreasing = TRUE), 20)
freq.nweights  <- head(sort(itemFrequency(transactions.obj, weighted = FALSE), decreasing = TRUE), 20)

compare.df  <- data.frame(
	"items" = names(freq.weights),
	"score" = freq.weights,
	"items.nw" = names(freq.nweights),
	"score.nw" = freq.nweights)

row.names(compare.df) <- NULL
