# normal distribution - gaussian

# 10 draws from standard 0-1 normal dist
rnorm(10)
# 10 draws from 100-20 normal dist
rnorm(n=10, mean=100, sd=20)

# dnorm - density (prob of particular value)
randNorm10  <- rnorm(10)
randNorm10
dnorm(randNorm10)

# seeing normal dist
randNorm  <- rnorm(30000)
randDensity  <- dnorm(randNorm)
ggplot(data.frame(x=randNorm, y=randDensity)) + aes(x=x, y=y) + geom_point() + labs(x="Random Normal Variables", y="Density")

# pnorm() - dist of normal dist - cum prob that given number occurs
# pnrom() - left tailed - probability is the area under the curve
pnorm(randNorm10)
# prob variable falls between two points - calc two probs and subtract
pnorm(1) - pnorm(0)

# ggplot2 object - build upon later
p  <- ggplot(data.frame(x=randNorm, y=randDensity)) + aes(x=x, y=y) + geom_line() + labs(x="x", y="Density")
neg1Seq  <- seq(from=min(randNorm), to=-1, by=.1)
lessThanNeg1  <- data.frame(x=neg1Seq, y=dnorm(neg1Seq))
head(lessThanNeg1)
lessThanNeg1  <- rbind(c(min(randNorm), 0),
                       lessThanNeg1,
                       c(max(lessThanNeg1$x), 0))
p + geom_polygon(data=lessThanNeg1, aes(x=x, y=y))

neg1Pos1Seq  <- seq(from=-1, to=1, by=.1)
neg1To1  <- data.frame(x=neg1Pos1Seq, y=dnorm(neg1Pos1Seq))
head(neg1To1)

neg1To1  <- cbind(c(min(neg1To1$x), 0)
                  neg1To1,
                  c(max(neg1To1$x), 0))

p + geom_polygon(data=neg1To1, aes(x=x, y=y))

# qnorm() - given cum prob - gives quantile
qnorm(pnorm(randNorm10))


##### BINOMIAL DISTRIBUTION


# random values =/= numbers, # of successful independent trials

# simulate random # of successes out of 10 trials, prob = 0.4 of success, n=1 (one run of trial)
rbinom(n=1, size=10, prob=.4)
rbinom(n=5, size=10, prob=.4) # run 5 trials

# size == 1 -> Bernoulli random var -> two outputs (1 = success, 0 = failure)
rbinom(n=1, size=1, prob=.4)

binomData  <- data.frame(Successes=rbinom(n=10000, size=10, prob=.3))
ggplot(binomData, aes(x=Successes)) + geom_histogram(binwidth=1)

binom5  <- data.frame(Successes=rbinom(n=10000, size=5, prob=.3), Size=5)
dim(binom5)
head(binom5)

binom10  <- data.frame(Successes=rbinom(n=10000, size=10, prob=.3), Size=10)
binom100  <- data.frame(Successes=rbinom(n=10000, size=10, prob=.3), Size=100)
binom1000  <- data.frame(Successes=rbinom(n=10000, size=10, prob=.3), Size=1000)
binomAll  <- rbind(binom5, binom10, binom100, binom1000)
dim(binomAll)
head(binomAll, 10)
tail(binomAll)

ggplot(binomAll, aes(x=Successes)) + geom_histogram() + facet_wrap(~ Size, scales="free")

# dbinom() - density (prob of an exact value)
# pbinom() - distribution (cumulative probability)

# prob 3 successes out of 10
dbinom(x=3, size=10, prob=.3)
# prob of 3 or fewer successes out of 10
pbinom(q=3, size=10, prob=.3)

# qbinom() - returns the quantile for given prob
qbinom(p=.3, size=10, prob=.3)


##### POISSON DISTRIBUTION


# for count data
# rpois, dpois, ppois, qpois
