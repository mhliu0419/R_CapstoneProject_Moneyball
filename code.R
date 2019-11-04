library(dplyr)
library(ggplot2)


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


batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)

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


combo_2001 <- subset(combo, yearID == 2001)

ggplot(combo_2001, aes(x=OBP, y=salary)) + geom_point(size=2)


combo_2001_revised <- subset(combo_2001, salary < 8000000 & OBP > 0 & AB > 450)

ggplot(combo_2001_revised, aes(x=OBP, y=salary)) + geom_point(size=2)

combo_2001_revised_sorted <- arrange(combo_2001_revised, desc(OBP))
combo_2001_revised_sorted[,c('playerID', 'AB','salary','OBP')]

#############
# In a new method, I am gonna use three for loops to dynamically select three players one by one from 643 candidates


combo_2001_short <- combo_2001[,c('playerID', 'salary', 'AB', 'OBP')]
combo_2001_short <- subset(combo_2001_short, OBP > 0)
#num_players <- dim(combo_2001_short)[1]
num_players = 300

combined_salary = 0
combined_AB = 0
combined_OBP = 0

desired_salary = 15000000
desired_totalAB = sum(lost_players$AB)
desired_totalOBP = sum(lost_players$OBP)


###

combination <- combn(1:20,3)

for(a in 1:dim(combination)[2]) {
  
  if ((sum(combo_2001_short[combination[,a],]$salary) <= 15000000) 
      & (sum(combo_2001_short[combination[,a],]$AB) >= 1469) 
      & (sum(combo_2001_short[combination[,a],]$OBP) >= 1.0916)) {
    
    print(combo_2001_short[combination[,a],])
    
  }
  
}

###



for (i in 1 : (num_players - 2)) {
  i = 1
  combined_salary = combined_salary + combo_2001_short[i,]$salary
  combined_AB = combined_AB + combo_2001_short[i,]$AB
  combined_OBP = combined_OBP + combo_2001_short[i,]$OBP
  
  
  for (j in (i + 1) : (num_players - 1)) {
    
    combined_salary = combined_salary + combo_2001_short[j,]$salary
    combined_AB = combined_AB + combo_2001_short[j,]$AB
    combined_OBP = combined_OBP + combo_2001_short[j,]$OBP
    
    
    for (k in (j + 1) : num_players) {

      i = 4
      combined_salary = combined_salary + combo_2001_short[i,]$salary
      combined_AB = combined_AB + combo_2001_short[i,]$AB
      combined_OBP = combined_OBP + combo_2001_short[i,]$OBP
      
      j = 12
      combined_salary = combined_salary + combo_2001_short[j,]$salary
      combined_AB = combined_AB + combo_2001_short[j,]$AB
      combined_OBP = combined_OBP + combo_2001_short[j,]$OBP
      
      combined_salary = combined_salary + combo_2001_short[k,]$salary
      combined_AB = combined_AB + combo_2001_short[k,]$AB
      combined_OBP = combined_OBP + combo_2001_short[k,]$OBP
      
      if ((combined_salary <= desired_salary) & (combined_OBP >= desired_totalOBP) & (combined_AB >= desired_totalAB)) {
        print(combo_2001_short[c(i,j,k),])
      }
      
      combined_salary = 0
      combined_AB = 0
      combined_OBP = 0

    }
  }
}

