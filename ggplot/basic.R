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
library(magrittr)
# save basic plot structure
g <- iris %>% ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Petal.Width))
# histogram
ggplot(iris, aes(x=Sepal.Length)) + geom_histogram()
# density
ggplot(iris, aes(x=Sepal.Length)) + geom_density()
# dotplot
ggplot(iris, aes(x=Sepal.Length, color=Species)) + geom_dotplot()
# bar chart
ggplot(iris, aes(Species, Sepal.Length)) + geom_bar(stat="identity")
# bar chart, filling with color
ggplot(iris, aes(Species, Sepal.Length, fill=Species)) + geom_bar(stat="identity") + theme_minimal()
# changing the size of observations
ggplot(iris, aes(Sepal.Length, Sepal.Width, color=Species, size=Petal.Width)) + geom_point()

# subsetting the data
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + geom_point(data=subset(iris, Species %in% c("setosa", "virginica")))
# swith X and Y axes
d + coord_flip()
library(ggthemes)
ggplot(iris, aes(x=Sepal.Length)) + geom_histogram() + theme_solarized(light=FALSE)
ggplot(iris, aes(x=Sepal.Length)) + geom_histogram() + theme_hc(bgcolor="darkunica")
iris %>%
  ggplot(
         aes(x=Sepal.Length, y=Sepal.Width,
             color=Species)) +
          geom_point() +
          theme_hc(bgcolor="darkunica") +
          scale_colour_hc("darkunica")
