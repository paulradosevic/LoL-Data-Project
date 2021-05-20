rawloldata <- read_csv("C:/Users/paulr/OneDrive/Documents/R/Project Data/games.csv")
leaguegames %>% view()

install.packages("rjson")
rawlolnamesjson <- RJSONIO::fromJSON("C:/Users/paulr/OneDrive/Documents/R/Project Data/champion_info_2_edit.json")
rawlolnames <- as_tibble(transpose(rawlolnamesjson)) %>% as.integer(unlist(rawlolnames$id))


rawlolnames <- rawlolnamesjson %>% 
  transpose() %>% 
  as_tibble() %>% 
  unnest(c(title, id, key, name))
install.packages("RJSONIO")
library(RJSONIO)
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


library(anytime)
library(tidyverse)
library(ggplot2)
library(modelr)
library(gapminder)
library(broom)
library(nycflights13)
library(lubridate)
library(stringr)
library(rjson)
library(purrr)
epoch_convert <- function(x) {
  as_datetime(x/1000)
} #this converts the times to ymd times
leaguegames %>% select(gameDuration, winner, firstBlood, firstTower, firstInhibitor, firstBaron, firstDragon, firstRiftHerald) %>% summary()

leaguegames <- rawloldata %>% 
  as_tibble() %>% 
  inner_join(rawlolnames, by = c("t1_champ1id" = "id")) %>% 
  mutate(
    creationTime = epoch_convert(creationTime),
    gameDuration = gameDuration %/% 60,
    winner = as.factor(winner),
    firstBlood = as.factor(firstBlood),
    firstTower = as.factor(firstTower),
    firstInhibitor = as.factor(firstInhibitor),
    firstBaron = as.factor(firstBaron),
    firstDragon = as.factor(firstDragon),
    firstRiftHerald = as.factor(firstRiftHerald)
  ) %>% filter(gameDuration > 5)

winperobj <- leaguegames %>% 
  filter(winner == 1) %>% 
  mutate(
    propfirstBlood = n(firstBlood),
    propfirstTower = n(firstTower),
    propfirstInhibitor = n(firstInhibitor),
    propfirstBaron = n(firstBaron),
    propfirstDragon = n(firstDragon),
    propfirstRift = n(firstRiftHerald)
  )

leaguegames %>% ggplot(aes(x = name)) + geom_bar() + coord_flip()
leaguegames %>% select(gameDuration, winner, firstBlood, firstTower, firstInhibitor, firstBaron, firstDragon, firstRiftHerald) %>% summary()

ggplot(leaguegames, aes(x = "", y = nrow(winner), fill = winner)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0)

leaguegames %>% 
  ggplot(aes(x = 1, fill = firstBlood)) +
  geom_bar()

leaguegames %>% 
  ggplot(aes(x = gameDuration)) + geom_bar() +
  labs(title = "Distributions of games by their duration", x = "Game duration in minutes", y = "Number of Games")


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
