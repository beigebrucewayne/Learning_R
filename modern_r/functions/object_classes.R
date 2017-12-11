x <- c(13, 21, 19, 18, 21, 16, 21, 24, 17, 18, 12, 18, 29, 17, 18,
  11, 13, 20, 25, 18, 15, 19, 21, 21, 7, 12, 23, 31, 16, 19, 23, 15,
  25, 19, 15, 25, 25, 16, 29, 15, 26, 29, 23, 24, 20, 19, 14, 27, 22, 26)

## S3 Class Objects

class(x)

# creating new class
class(x)  <- "robustSummary"
# remove class
y  <- unclass(x)

# print method  <- robustSummary
print.robustSummary  <- function(obj) {

	cat('Median ', median(obj), "\n")
	cat('Median Absolute Deviation (MAD)', mad(obj), "\n")
	cat('First Quartile (Q1)', as.numeric(quantile(obj, probs = 0.25)), "\n")
	cat('Third Quartile (Q3)', as.numeric(quantile(obj, probs = 0.75)), "\n")

}


# generic function
robSum  <- function(obj) {

	UseMethod("robSum")

}

# default method
robSum.default  <- function(obj) {

	cat('This is a generic function for the obj class - robustSummary')

}

# new method for robSum() generic function
robSum.robustSummary  <- function(obj) {

	cat('Median ', median(obj), '\n')
	cat('Median Absolute Deviation (MAD)', mad(obj), '\n')
	cat('First Quantile (Q1)', as.numeric(quantile(obj, probs = 0.25)), '\n')
	cat('Third Quantile (Q3)', as.numeric(quantile(obj, probs = 0.75)), '\n')

}


set.seed(123)
newX  <- rnorm(50)
robSum.default(obj = newX)

class(newX)  <- "robustSummary"
robSum.default(obj = newX)

robSum.robustSummary(obj = newX)

# normal function
myFun  <- function(obj) {...}

# generic function
myFun  <- function(obj) { UseMethod("robSum") }


## S4 object  class


# define new S4 class
new()
setClas()


robSum  <- function(obj) {

	med  <- median(obj)
	mad  <- mad(obj)
	q1  <- as.numeric(obj, probs = 0.25)
	q3  <- as.numeric(obj, probs = 0.75)
	return (list(median = med, mad = mad, q1 = q1, q3 = q3))

}

rStats  <- robSum(obj = x)
rStatsS4  <- new("robustSummary", median = rStats$median, mad = rStats$mad, q1 = rStats$q1, q3 = rStats$q3)


## S4 using constructor function

robustSummary  <- setClass("robustSummary",
	slots = list(
		median = "numeric",
		mad = "numeric",
		q1 = "numeric",
		q3 = "numeric"
	)
)

robustSummary
