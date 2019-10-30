library(dplyr)


# Load the data for all players performance statistics

batting <- read.csv('/Users/AncelotLiu/Desktop/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training\ Exercises/Capstone\ and\ Data\ Viz\ Projects/Capstone\ Project/Batting.csv')

# To show the data of batting

head(batting)

str(batting)

head(batting$AB)
head(batting$X2B)


# Adding new columns to batting data


batting$BA <- batting$H / batting$AB
tail(batting$BA,5)


batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$BB + batting$HBP)

batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR

batting$SLG <- ((1 * batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR) ) / batting$AB


str(batting)


# Load the data of player salary


sal <- read.csv('/Users/AncelotLiu/Desktop/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training\ Exercises/Capstone\ and\ Data\ Viz\ Projects/Capstone\ Project/Salaries.csv')

summary(sal)

batting <- subset(batting, yearID >= 1985)

summary(batting)


# Combine batting data with salary data according to playerID and year


combo <- merge(batting,sal,by = c('playerID', 'yearID'))

summary(combo)


# To only show the three lost players' data in 2001


lost_players <- subset(combo, playerID %in% c('giambja01','damonjo01','saenzol01'))
lost_players

lost_players <- subset(lost_players, yearID == 2001)
lost_players <- lost_players[,c('playerID', 'H', 'X2B','X3B','HR','OBP','SLG','BA','AB')]


lost_players


# Use 3 constraints to find replacement for 3 lost kep players

# The total combined salary of the three players can not exceed 15 million dollars.
# Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
# Their mean OBP had to equal to or greater than the mean OBP of the lost players



