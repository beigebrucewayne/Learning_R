# install.packages('xlsx')

library(xslx)

# save to excel
write.xlsx(auto, file = "auto.xlsx", sheetName = "autobase", row.names = FALSE)

# add new columns
auto$kmpg  <- aut$mpg * 1.6
auto$mpg_deviation  <- (auto$mpg - mean(auto$mpg)) / auto$mpg

# create excel objects
auto.wb  <- createWorkbook()
sheet1  <- createSheet(auto.wb, "auto1")
rows  <- createRow(sheet1, rowIndex = 1)
cell.1  <- createCell(rows, colIndex = 1)[[1, 1]]
setCellValue(cell.1, "Hello Auto Data!")
addDataFrame(auto, sheet1, startRow = 3, row.names = FALSE)

# assign styles to cells
cs  <- CellStyle(auto.wb) + Font(auto.wb, isBold = TRUE, color = "red")
setCellStyle(cell.1, cs)
saveWorkbook(auto.wb, "auto_wb.xlsx")

# add another sheet to excel workbook
wb  <- loadWorkbook("auto_wb.xlsx")
sheet2  <- createSheet(auto.wb, "auto2")
addDataFrame(auto[1:9], sheet2, row.names = FALSE)
saveWorkbook(auto.wb, "auto_wb.xlsx")

# add columns, save workbook
wb  <- loadWorkbok("auto_wb.xlsx")
sheets  <- getSheets(wb)
sheet  <- sheets[[2]]
addDataFrame(auto[,10:11], sheet, startColumn = 10, row.names = FALSE)
saveWorkbook(wb, "newauto.xlsx")

# read from excel
new.auto  <- read.xlsx("newauto.xlsx", sheetIndex = 2)
head(new.auto)
new.auto  <- read.xlsx("newauto.xlsx", sheetName = "auto2")

# read specific region
sub.auto  <- read.xlsx("newauto.xlsx", sheetName = "autobase", rowIndex = 1:4, colIndex = 1:9)
