# 3 vectors -> 1 data.frame
sport  <- c("Hockey", "Baseball", "Football")
league  <- c("NHL", "MLB", "NFL")
trophy  <- c("Stanley Cup", "Comissioner's Trophy", "Vince Lombardi Trophy")
trophies1  <- cbind(sport, league, trophy)

# another data.frame using data.frame()
trophies2  <- data.frame(
  sport = c("Basetball", "Golf"),
  league = c("NBA", "PGA"),
  trophy = c("Larry O'Brien Championship Trophy", "Wanamaker Trophy"),
  stringsAsFactors = FALSE)

# combine 2 df -> 1 df
trophies  <- rbind(trophies1, trophies2)

cbind(Sport = sport, Associatoin = league, Prize = trophy)


