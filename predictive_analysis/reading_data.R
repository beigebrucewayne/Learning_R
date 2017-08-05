# READ CSV

theURL  <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato  <- read.table(file=theUrl, header=TRUE, sep=",")

# strings as factors
x  <- 10:1
y  <- -4:5
q  <- c("Hockey", "Football", "Baseball", "Curling", "Rugby")
theDF  <- data.frame(First=x, Second=y, Sport=q, stringsAsFactors=FALSE)
theDF$Sport # "Hockey" "Football" "Baseball" etc...

# Readr package - part of tidyverse
library(readr)
theUrl  <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato2  <- read_delim(file=theUrl, delim=',')

# EXCEL DATA

# download file from internet from R
download.file(url="http://www.jaredlander.com/data/ExcelExample.xlsx", destfile='data/ExceExample.xlsx', method='curl')
library(readxl)
excel_sheets('data/ExcelExample.xlsx')
tomatoXL  <- read_excel('data/ExcelExample.xlsx')

# which sheet to read
wineXL1  <- read_excel('data/ExcelExample.xlsx', sheet=2) # using position
wineXL2  <- read_excel('data/ExcelExample.xlsx', sheet='Wine') # using name

# READING FROM DATABASES

download.file("http://www.jaredlander.com/data/diamonds.db", destfile="data/diamonds.db", mode='wb')
library(RSQLite)
drv  <- dbDriver('SQLite') # specificying driver
con  <- dbConnect(drv, 'data/diamonds.db')
dbListTables(con) # "DiamondColors" "diamonds" "sqlite_stat1"
dbListFields(con, name='diamonds') # "carat" "cut" "color"

# Simple SELECT * query from one table
diamondsTable  <- dbGetQuery(con,
  "SELECT * FROM diamonds",
  stringsAsFactors=FALSE)

# A join between tables
longQuery  <- "SELECT * FROM diamonds, DiamondColors
  WHERE
  diamonds.color = DiamondColors.Color"
diamondsJoin  <- dbGetQuery(Con, longQuery, stringsAsFactors=FALSE)
