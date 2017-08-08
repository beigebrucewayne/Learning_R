# univariate data - samples of one variable
categorical.data  <- c("heads", "tails", "tails", "heads")
contin.data  <- c(198.14, 148.45, 240.95, 230.94)

# Frenquency Distributions

head(mtcars) # see data overview
unique(mtcars$cyl) # unique values of cyl column
table(mtcars$cyl) # table showing count for each unique value of column

# use cut to create bins
cut(airquality$Temp, 9) # cut column into 9 bins
table(cut(airquality$Temp, 9))

# summary() - quick desc stats for each column

# average deviation
sum(abs(x - mean(x))) / length(x)

# variance - std dev ^ 2
# std dev - square root of variance

# get prob of  car with N carburetors
table(mtcars$carb) / length(mtcars$carb)

# (PMF) probability mass function - bar chart of probabilities
# (PDF) proabbility density function - likelyhood experienc some event

# percent of pdf that falls between two points
temp.density  <- density(airquality$Temp)
pdf  <- approxfun(temp.density$x, temp.density$y, rule=2)
integrate(pdf, 80, 90)
