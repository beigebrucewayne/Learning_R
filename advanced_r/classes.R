library(ggplot2)

# S3 Class System

x <- table(mtcars$cyl)
class(x) <- c("newclass", "table")
class(x)

d <- data.frame(
  x = c(1, 3, 4),
  y = c(1, 4, 5),
  labels = c("First", "Second", "Third")
)

class(d) <- "textplot"
print(d)

class(d) <- c("textplot", "data.frame")
print(d)
