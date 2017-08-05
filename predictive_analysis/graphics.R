# Base histograms
hist(diamonds$carat, main="Carat Histogram", xlab="Carat")

# Base scatterplot
plot(price ~ carat, data=diamonds)
plot(diamonds$carat, diamonds$price)

# Base boxplot
boxplot(diamonds$carat)


# ggplot2 histogram and density
ggplot(data=diamonds) + geom_histogram(aes(x=carat))

ggplot(data=diamonds) + geom_density(aes(x=carat), fill="grey50")


# ggplot2 scatterplots
ggplot(diamonds, aes(x=carat, y=price)) + geom_point()

# save basics of ggplot object to a variable
g  <- ggplot(diamonds, aes(x=carat, y=price))

# color in scatterplot
g + geom_point(aes(color=color))

# scatterplot using facet grid to extract out individual data in scatterplot
g + geom_point(aes(color=color)) + facet_wrap(~color)
g + geom_point(aes(color=color)) + facet_grid(cut~clarity)

# facet_wrapt + histogram
ggplot(diamonds, aes(x=carat)) + geom_histogram() + facet_wrap(~color)


# ggplot boxplots and violin plots
ggplot(diamonds, aes(y=carat, x=1)) + geom_boxplot()

# multiple boxplots
ggplot(diamonds, aes(y=carat, x=cut)) + geom_boxplot()

# violin boxplots
ggplot(diamonds, aes(x=carat, y=cut)) + geom_violin()


# ggplot2 line graphs
ggplot(economics, aes(date, y=pop)) + geom_line()


# lubridate package - tidyverse - working with dates easier
library(lubridate)
economics$year  <- year(economics$date) # create year and month var
economics$month  <- month(economics$date, label=TRUE) # label means result should be name of month and not number
econ2000  <- economics[which(economics$year >= 2000),] # subset, which() -> indices obs == TRUE
library(scales) # better axis formatting
g  <- ggplot(econ2000, aes(x=month, y=pop)) # foundation of plot
g  <- g + geom_line(aes(color=factor(year), group=year)) # lines color coded and grouped by year, aes breaks data into sep groups
g  <- g + scale_color_discrete(name="Year") # legend = year
g  <- g + scale_y_continuous(labels=comma) # format y axis
g  <- g + labs(title="Population Growth", x="Month", y="Population")
g # plot the graph


# themes
library(ggthemes)
g2  <- ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=color))

# apply various themes
g2 + theme_economist() + scale_colour_economist()
g2 + theme_excel() + scale_colour_excel()
g2 + theme_tufte()
g2 + theme_wsj()
