# assigning value
basic <- 5

# printing out value
print(basic)

runDistance <- 800
# runDistance of type 'numeric'
print(class(runDistance))

favoriteDessert <- "Peanut Butter Cup"
# of type 'character'
print(class(favoriteDessert))


# vector creation, list/array
applePrices <- c(113, 114, 115)
russianPresidents <- c("Mikhail Gorbachev", "Boris Yeltsin", "Vladimir Putin")

# values are equivalent
dogCount <- 1
catCount <- c(1)
print(identical(dogCount, catCount))

# R is 1-indexed
# vector slicing
a <- c(3,5)
a[1] # 3
a[2] # 5

# assign tenth value to new variable
salary <- salaries[10]
salariesLength <- length(salaries)

# adds 2 to every number in vector
a <- c(2, 3, 4)
a + 2
# overwriting variable
a <- a + 2

