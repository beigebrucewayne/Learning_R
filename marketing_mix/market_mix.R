# sales = base + b1 * (advertising)

  # two assumptions
    # is linear
    # base is constant

sales <- c(37, 89, 82, 58, 110, 77, 103, 78, 95, 106, 98, 96, 68, 96, 157, 198, 145, 132, 96, 135)
ad <- c(6, 27, 0, 0, 20, 0, 20, 0, 0, 18, 9, 0, 0, 0, 13, 25, 0, 15, 0, 0)

# fit simple linear model
modFit.0  <- lm(sales ~ ad)
summary(modFit.0)

# complexity 1 -> adstock case

  # adstock transformation -> past ads affect present and future sales

# new model
# sales = base + b1 * f(advertising | a )

ad.adstock  <- as.numeric(filter(x=ad, filter=.50, method="recursive"))

modFit.1  <- lm(sales ~ ad.adstock)
summary(modFit.1)

# complexity 2 -> more advertising variables

# sales = base + E(i=1)bi * f(advertising(i) | a(i))

sales <- c(37, 89, 82, 58, 110, 77, 103, 78, 95, 106, 98, 96, 68, 96, 157, 198, 145, 132, 96, 135)
ad1 <- c(6, 27, 0, 0, 20, 0, 20, 0, 0, 18, 9, 0, 0, 0, 13, 25, 0, 15, 0, 0)
ad2 <- c(3, 0, 4, 0, 5, 0, 0, 0, 8, 0, 0, 5, 0, 11, 16, 11, 5, 0, 0, 15)

ad1.adstock  <- as.numeric(filter(x=ad1, filter=.3, method="recursive"))
ad2.adstock  <- as.numeric(filter(x=ad2, filter=.3, method="recursive"))

modFit.2  <- lm(sales ~ ad1.adstock + ad2.adstock)
summary(modFit.2)

# complexity 3 -> changing base & other vars

  # base non-constant
      # base more than intercept
      # notice increasing trend in sales -> create trend variable -> add to base

  # distribution points -> accounts for number of outlets product sold
      # double stores -> more sales

  # pricing & promotions

# sales = a(o) + a(1) * trend + a(2) * distribution + E(i=1) * f(advertising(i) | a(i))

trend <- 1:20

modFit.3  <- lm(sales ~ trend + ad1.adstock + ad2.adstock)
summary(modFit.3)

# contribution = b(i) * f(advertising(i) | a(i))
