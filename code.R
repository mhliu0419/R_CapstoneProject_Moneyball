batting <- read.csv('/Users/ml4274/Downloads/R_CapstoneProject_Moneyball-master/Batting.csv')

head(batting)

str(batting)

head(batting$AB)
head(batting$X2B)


batting$BA <- batting$H / batting$AB
tail(batting$BA,5)


batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$BB + batting$HBP)

batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR

batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR) ) / batting$AB
