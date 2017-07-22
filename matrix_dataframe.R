# load dataset
whiteHouse <- read.csv("2015_white_house.csv")

# create matrix
# vector to turn into matrix ( number or rows, number of columns )
B <- matrix(c(1,2,3,4,5,6), 3, 2)
C <- matrix(c("Rambo", "Chuck Norris", "Arnold", "Steven Seagal", "John Wayne", "Steve McQueen"), 2, 3)

# grabbing values from a matrix
c22 <- C[2,2]
c13 <- C[1,3]

# grabbing entire column or row
c20 <- C[2,] # entire row
c03 <- C[,3] # entire column

# matrix has to be all one data type

# read.csv -> automatically saves as dataframe
whiteHouse[1, "Salary"] # get salary of first employee
whiteHouse["Salary"] # entire "Salary" column from dataframe

# find average salary
totalSalaries <- sum(whiteHouse["Salary"])
totalEmployees <- nrow(whiteHouse)
averageSalary <- totalSalaries / totalEmployees

# finding min and max
highestSalary <- max(whiteHouse["Salary"])
lowestSalary <- min(whiteHouse["Salary"])

# two ways to grab a column
whiteHouse["Salary"] # dataframe object
whiteHouse[,"Salary"] # returns vector

# find name of employee with highest salary
highIndex <- which.max(whiteHouse[,"Salary"]) # need vector to perform which.max
maxSalaryRow <- whiteHouse[highIndex,]
highestEarner <- maxSalaryRow["Name"]
