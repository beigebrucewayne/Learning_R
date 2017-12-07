# checkign for missing values

if(any(is.na(x))) {

	cat("There are missing values in x at \n")
	which(is.na(x))

}


# functions in switch statements

option1  <- function(x, sym) {

	swtich(sym,
		classical = c(mean = mean(x, na.rm = T), std = sd(x, na.rm = T)),
		robust = c(med = median(x, na.rm = T), mad = mad(x, na.rm = T))
	)

}
