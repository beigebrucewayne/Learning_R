v1 <- c(3, 7, 2, 6, 9)


## named params

fDescriptive  <- function(numVec, type = "classical") {

	avg <- mean(numVec)
	std <- sd(numVec)
	med <- median(numVec)
	medad <- mad(numVec)
	out1 <- c(mean = avg, sd = std)
	out2 <- c(median = med, mad = medad)

	if (type == "classical") {
		return (out1)
	} else if (type == "robust") {
		return (out2)
	}

}


## checking types

fDescriptive <- function(numVec, type = "classical") {

	type <- tolower(type)
	if (is.numeric(numVec) & is.vector(numVec)) {
		avg <- mean(numVec)
		std <- sd(numVec)
		med <- median(numVec)
		medad <- median(numVec)
		out1 <- c(mean = avg, sd = std)
		out2 <- c(median = med, mad = medad)

		if (type == "classical") {
			return (out1)
		} else if (type == "roubst") {
			return(out2)
		}

	}

}


## outputting as different data type

meanSe <- function(numVec) {

	if (is.numeric(numVec) & is.vector(numVec)) {
		avg <- mean(numVec)
		std <- sd(numVec)
		se <- std / sqrt(length(numVec))

		out <- paste("Mean of the input vector is = ",
					 paste(avg), " with a standard error = ",
					 paste(round(se, 2)), sep = "")

		return (out)
	}

}


## returning a list

meanSe <- function(numVec) {

	if (is.numeric(numVec) & is.vector(numVec)) {
		avg <- mean(numVec)
		std <- sd(numVec)
		se <- sd(numVec)
		out <- list(mean = avg, standardError = se)

		return (out)
	}
}


## recursion

fDescriptive <- function(numVec, type = "classical") {

	avg <- mean(numVec)
	std <- sd(numVec)
	med <- median(numVec)
	medad <- mad(numVec)
	out1 <- c(mean = avg, sd = std)
	out2 <- c(median, mad = medad)

	if (type == "classical")
		return (out1)
	else if (type == "robust")
		return (out2)
}

## calc robust stats -> four columns of iris df

robustSummary <- apply(X = iris[, -5], MARGIN = 2, FUN = fDescriptive, type = "robust")


## cubic sum

cubicSum <- function(n) {

	if (n == 0)
		return (0)
	else
		return(n ^ 3 + cubicSum(n - 1))

}


## handling errors

logX <- function(numVec1) {

	if (any(numVec1 < 0))
		stop("A negative value exists")
	else logV1 <- log(numVec1)

	return(logV1)

}


## stop()

logX  <- function(numVec1) {

	if(any(numVec1 < 0))
		stop("A negative value exists")
	else logV1  <- log(numVec1)
		return(logV1)

}


## try()

logX1  <- function(numVec1) {

	try(logV1  <- log(numVec1))
	return(logV1)

}


## tryCatch()

logX2  <- function(numVec1) {

	tryCatch(
		return(logV1  <- log(numVec1)),
		warning = function(w) print("A negative input occured")
	)

}
