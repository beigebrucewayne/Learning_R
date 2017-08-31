# creating a ggplot
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))


# general graphing template
ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


# scatter plot, colored by attribute
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))


# manual setting properties
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color="blue")


# facet wrap - useful for categorical variables
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2)


# geom_smooth, using different linetype for each
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))


# color and turn off legend
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)


# adding multiple geoms
# NOT PREFFERED METHOD
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + geom_smooth(mapping = aes(x = displ, y = hwy))


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth()


# different aesthetics different layers
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + geom_smooth()


# different data for each layer
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)


# BAR CHART


# basic bar chart
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))


# overriding default stat
deom  <- tribble(
    ~a,     ~b,
    "bar_1", 20,
    "bar_2", 30,
    "bar_3", 40
)

ggplot(data = demo) + geom_bar(mapping = aes(x = a, y = b), stat = "identity")


# using stat_summary
ggplot(data = diamonds) + stat_summar(mapping = aes(x = cut, y = depth), fun.ymin = min, fun.ymax = max, fun.y = median)


# color fill bar chart
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, gill = cut))


# easier way to view individual values within bar chart
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
