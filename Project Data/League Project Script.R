rawloldata <- read.csv("C:/Users/paulr/OneDrive/Documents/R/Project Data/games.csv")
leaguegames %>% view()

#This is a collection of over 50,000 ranked EUW games from the game League of Legends, as well as json files containing a way to convert between champion and summoner spell IDs and their names. For each game, there are fields for:
  
#  Game ID
#Creation Time (in Epoch format)
#Game Duration (in seconds)
#Season ID
#Winner (1 = team1, 2 = team2)
#First Baron, dragon, tower, blood, inhibitor and Rift Herald (1 = team1, 2 = team2, 0 = none)
#Champions and summoner spells for each team (Stored as Riot's champion and summoner spell IDs)
#The number of tower, inhibitor, Baron, dragon and Rift Herald kills each team has
#The 5 bans of each team (Again, champion IDs are used)
#This dataset was collected using the Riot Games API, which makes it easy to lookup and collect 
#information on a users ranked history and collect their games. However finding a list of usernames is the hard part, 
#in this case I am using a list of usernames scraped from 3rd party LoL sites.

install.packages("anytime")
library(anytime)
library(tidyverse)
library(modelr)
library(gapminder)
library(broom)
library(nycflights13)
library(lubridate)
library(stringr)

anytime(1.504279e+12)

as_datetime(x/1000)

epoch_convert <- function(x) {
  as_datetime(x/1000)
} #this converts the times to ymd times

logicinto_factor <- function(x) {
  mutate(
    x = as.factor(x)
  )
}

leaguegames <- rawloldata %>% 
  as_tibble() %>% 
  mutate(
    creationTime = epoch_convert(creationTime),
    winner = as.factor(winner),
    firstBlood = as.factor(firstBlood),
    firstTower = as.factor(firstTower),
    firstInhibitor = as.factor(firstInhibitor),
    firstBaron = as.factor(firstBaron),
    firstDragon = as.factor(firstDragon),
    firstRiftHerald = as.factor(firstRiftHerald)
  )
  



leaguegames %>% 
  ggplot(aes(x = winner, fill = firstBlood)) + geom_bar(position = "fill") +
  labs(title = "Winrate proportion on acquiring first blood")

leaguegames %>% 
  ggplot(aes(x = winner, fill = firstTower)) + geom_bar(position = "fill") + 
  labs(title = "Winrate proportion on acquiring first tower")

leaguegames %>% 
  ggplot(aes(x = winner, fill = firstInhibitor)) + geom_bar(position = "fill") + 
  labs(title = "Winrate proportion on acquiring first inhibitor")

leaguegames %>% 
  ggplot(aes(x = winner, fill = firstBaron)) + geom_bar(position = "fill") + 
  labs(title = "Winrate proportion on acquiring first baron")

leaguegames %>% 
  ggplot(aes(x = winner, fill = firstDragon)) + geom_bar(position = "fill") + 
  labs(title = "Winrate proportion on acquiring first dragon")

leaguegames %>% 
  ggplot(aes(x = winner, fill = firstRiftHerald)) + geom_bar(position = "fill") + 
  labs(title = "Winrate proportion on acquiring first rift herald")


install.packages("usethis")
library(usethis)
use_git_config(user.name = "paulradosevic", user.email = "paul.radosevic@gmail.com")
