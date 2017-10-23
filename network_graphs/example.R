library(networkD3)

src  <- c('A', 'B', 'C', 'A', 'A', 'B')
target  <- c('B', 'C', 'A', 'E', 'F', 'B')
networkData  <- data.frame(src, target)

simpleNetwork(networkData)
