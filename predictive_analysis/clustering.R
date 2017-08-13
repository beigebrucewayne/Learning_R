##### K-MEANS #####

wineUrl  <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data'
wine  <- read.table(wineUrl, header=FALSE, sep=",", stringsAsFactors=FALSE,
                    col.names=c('Cultivar', 'Alcohol', 'Malic.acid',
                               'Ash', 'Alcalinity.of.ash',
                               'Magnesium', 'Total.phenols',
                               'Flavanoids', 'Nonflavanoid.phenols',
                               'Proanthocyanin', 'Color.intensity',
                               'Hue', 'OD280.OD315.of.diluted.wines',
                               'Proline'))
head(wine)
# cultivar column may be too correlated with membership, so it's dropped
wineTrain  <- wine[,which(names(wine) != "Cultivar")]
# set seed for reproducible results
set.seed(2786113)
wineK3  <- kmeans(x=wineTrain, centers=3)
wineK3
# use useful library to deal with k-means high demsionality plotting
library(useful)
plot(wineK3, data=wineTrain)
plot(wineK3, data=wine, class="Cultivar")
# random start
set.seed(2786113)
wineK3N25  <- kmeans(wineTrain, centers=3, nstart=25)
# cluster sizes with 1 start
wineK3$size
# cluster sizes with 25 starts
wineK3N25$size
wineBest  <- FitKMeans(wineTrain, max.clusters=20, nstart=25, seed=2786113)
wineBest
PlotHartigan(wineBest)
table(wine$Cultivar, wineK3N25$cluster)
plot(table(wine$Cultivar, wineK3N25$cluster),
     main="Confusion Matrix for Wine Clustering",
     xlab="Cultivar", ylab="Cluster")
# Gap statistic - compare within-cluter dissimilarity for clustering of data with that of a bootstrapped sample of data
library(cluster)
theGap  <- clusGap(wineTrain, FUNcluster=pam, K.max=20)
gapDF  <- as.data.frame(theGap$Tab)
gapDF
# logW cruves
ggplot(gapDF, aes(x=1:nrow(gapDF))) +
  geom_line(aes(y=logW), color="blue") +
  geom_point(aes(y=logW), color="blue") +
  geom_line(aes(y=E.logW), color="green") +
  geom_point(aes(y=E.logW), color="green") +
  labs(x="Number of Clusters")
# gap curve
ggplot(gapDF, aes(x=1:nrow(gapDF))) +
  geom_line(aes(y=gap), color="red") +
  geom_point(aes(y=gap), color="red") +
  geom_errorbar(aes(ymin=gap-SE.sim, ymax=gap+SE.sim), color="red") +
  labs(x="Number of Clusters", y="Gap")


##### K-MEDOIDS #####


# instead of center being mean, center is an actual observation (median)
# PAM (partioning around medoids)


##### HIERARCHICAL CLUSTERING #####


wineH  <- hclust(d=dist(wineTrain))
plot(wineH)
# hierarchical also works on categorical data
keep.cols  <- which(!names(wbInfo) %in% c("iso2c", "country", "year", "capital", "iso3c"))
wbDaisy  <- daisy(x=wbInfo[,keep.cols])
wbH  <- hclust(wbDaisy)
plot(wbH)
# cutting the clusters
plot(wineH)
# split into 3 clusters
rect.hclust(wineH, k=3, border="red")
# split into 13 clusters
rect.hclust(wineH, k=13, border="blue")
