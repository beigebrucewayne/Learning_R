library(ggplot2)

# two types of plots
ggplot()
qplot()

# 3 components to ggplot
  # 1. Data
  # 2. Set of geoms
  # 3. Coordinate system

head(iris)

# basic plot - no geom
ggplot(iris, aes(Sepal.Length, Sepal.Width))
# basic scatterplot
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()
# scatterplot with shape and color
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, shape=Species, color=Petal.Width)) + geom_point(size=5)
# basic layer
iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Petal.Width))
