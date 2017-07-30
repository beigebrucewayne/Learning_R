# survival analysis
	# WHEN is an event (purchase, response, etc...) most likely to occur?
	# HOW LIKELY is ""

# censored obs - obs wherein don't know status (event has not occured yet or was lost in some way)

# Cox regression, non-parametric partial likelihood technique (proportional hazards)

# survival analysis (type of regression)
	# uses partial likelihood, not maximum likelihood
	# dependent var is two parts
		# time until event
		# whether even has occured or not

# Cox regression uses hazard rate
	# 40 miles per hour
	# hazard quantifies rate of event in period of time

# Cox regression -> 1000 emails sent = purchases happen 3 days sooner

# how to increase LTV using survival analysis

# LTV uses historical data (only descriptive)

	# historical data -> sum each customer's total rev
	# sum - costs (cost to serve, cost to market, cogs, etc...)
	# net rev converted into annual avg ammount (cash flow)
	# cash flow decrease by say 10% year -> zero
	# future cash flows summed and discounted to get NPV
	# NPV = LTV, applied to each customer

# Predictive analysis over descriptive

	# LTV uses all historical data, with assumptions about future applied unilaterally to each customer
		# assumes past behaviour will continue into future

# Predictive analysis thruts LTV into the future
	# using independent vars to predict next time until purchase

# Value of survival analysis is in changing timing of purchases

	# DESCRIPTIVE - shows what happened
	# PREDICTIVE - glimpse of what might change the future

# behaviourally-based method
	# segment customers (based on behaviour)
		# behaviour - purchasing (amount, timing, share of products, etc...)
	# apply survival model to each segment
	# score each individual customer

# survival model shows independent variables effect on dependent variable

	# dependent var - time until purchase
	# independent var - price discounts, product bundling, seasonal messages, more emails
