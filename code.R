batting <- read.csv('/Users/AncelotLiu/Desktop/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training\ Exercises/Capstone\ and\ Data\ Viz\ Projects/Capstone\ Project/Batting.csv')


head(batting)

str(batting)

head(batting$AB)
head(batting$X2B)


batting$BA <- batting$H / batting$AB
tail(batting$BA,5)


batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$BB + batting$HBP)

batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR

batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR) ) / batting$AB


str(batting)



sal <- read.csv('/Users/AncelotLiu/Desktop/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training\ Exercises/Capstone\ and\ Data\ Viz\ Projects/Capstone\ Project/Salaries.csv')

summary(sal)

batting <- subset(batting, yearID >= 1985)

summary(batting)


combo <- merge(batting,sal,by = c('playerID', 'yearID'))

summary(combo)





