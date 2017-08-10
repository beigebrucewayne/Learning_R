# paste() - combines strings
paste("Hello", "Jared", "and others")
paste("Hello", "Jared", "and others", sep="/") # sep -> arg to separate

# vectors are not the same length, recycled Hello for_each
paste("Hello", c("Jared", "Bob", "David"))

# collapse vector -> vector with collapse()
vectorOfText  <- c("Hello", "Everyone", "out there", ".")
paste(vectorOfText, collapse=" ")

# sprintF - build one string with special markers

person  <- "Jared"
partySize  <- "eight"
waitTime  <- 25
sprintf("Hello %s, your party of %s will be seated in %s minutes", person, partySize, waitTime)

library(XML)
theURL  <- "http://www.loc.gov/rr/print/list/057_chron.html"
presidents  <- readHTMLTable(theURL, which=3, as.data.frame=TRUE, skip.rows=1, header=TRUE, stringsAsFactors=FALSE)
head(presidents)
tail(presidents$YEAR)
presidents  <- presidents[1:64,]

# split year string
yearList  <- str_split(string=presidents$YEAR, pattern = "-")

# combine into one matrix
yearMatrix  <- data.frame(Reduce(rbind, yearList))
head(yearMatrix)

# give columns good names
names(yearMatrix)  <- c("Start", "Stop")

# bind new columns -> dataframes
presidents  <- cbind(presidents, yearMatrix)

# convert start and stop into numeric
presidents$Start  <- as.numeric(as.character(presidents$Start))
presidents$Stop  <- as.numeric(as.character(presidents$Stop))
head(presidents)
tail(presidents)

# grab first 3 characters
str_sub(string=presidents$PRESIDENT, start=1, end=3)
# chars between 4th and 8th position
str_sub(string=presidents$PRESIDENT, start=4, end=8)
# presidents started in year ending in 1, got elected in year ending in 0, lot of these guys died in office
presidents[str_sub(string=presidents$PRESIDENT, start=4, end=4) == 1, c("YEAR", "PRESIDENT", "Start", "Stop")]

# Regex

# find president with name 'John' - first or last
# true/false if 'John' was found in the name
johnPos  <- str_detect(string=presidents$PRESIDENT, pattern="John")
presidents[johnPos, c("YEAR", "PRESIDENT", "Start", "Stop")]

# bad search
badSearch  <- str_detect(presidents$PRESIDENT, "john")
# good search
goodSearch  <- str_detect(presidents$PRESIDENT, ignore.case("John"))

# loading dataset from url
con  <- url("http://www.jaredlander.com/data/warTimes.rdata")
load(con)
close(con)

head(warTimes, 10)
warTimes[str_detect(string=warTimes, pattern="-")]

theTimes  <- str_split(string=warTimes, pattern="(ACAEA)|-", n=2)
head(theTimes)
which(str_detect(string=warTimes, pattern="-"))

# function to extract first element in each vector in a list
theStart  <- sapply(theTimes, FUN=function(x) x[1])
head(theStart)

# get rid of spaces around separator
theStart  <- str_trim(theStart)
head(theStart)

# return elements where "January" was detected
theStart[str_detect(string=theStart, pattern="January")]

# replace first digit with x
head(str_replace(string=theStart, pattern="\\d", replacement="x"), 30g
