# Exploratory Data Analysis

# (1.) Generate questions about data
# (2.) Seach for answers: visualize, transform and model
# (3.) Refine questions and/or generate new ones

# Two basic questions

# 1. What type of variation occurs within my variables?
# 2. What type of covariation occurs between my variables?


# Analyze distribution of categorical variable
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))

# manually get count
diamonds %>%
    count(cut)

# Analyse distribution of continuous variable
ggplot(data = diamonds) + geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# manually get count
diamonds %>%
    count(cut_width(carat, 0.5))

# zooming in
smaller  <- diamonds %>%
    filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat)) + geom_histogram(binwidth = 0.1)

# overlaying multiple histograms - use geom_freqpoly()
ggplot(data = smaller, mapping = aes(x = carat, color = cut)) + geom_freqpoly(binwidth = 0.1)

# replacing outliers
diamonds2  <- diamonds %>%
    mutate(y = ifelse(y < 3 | y > 20, NA, y))

# ifelse - 3 args
# 1 - test, logical vector
# 2 - value of test true
# 3 - value of test false

# supress missing values warning
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + geom_point(na.rm = TRUE)



########## COVARIATION ####################


# boxplot 
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_boxplot()

# reorder boxplot using medain
ggplot(data = mpg) + geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))
