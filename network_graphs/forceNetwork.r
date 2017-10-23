library(networkD3)
data(MisLinks)
data(MisNodes)

forceNetwork(
  Links = MisLinks,
  Nodes = MisNodes,
  Source = "source",
  Target = "target",
  Value = "value",
  NodeID = "name",
  Group = "group",
  opacity = 0.7,
  colourScale = JS("d3.scaleOrdinal(d3.schemeCategory20);"))
