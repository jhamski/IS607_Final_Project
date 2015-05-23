# IS607 Data Acquisition and Management | CUNY MS Data Analytics | James Hamski
# Script 3 - load data and create graph DB

# Project Goal: create a social graph of the R Stats community on Twitter
# Can we find different domain groups (i.e. biostats, finance)?
# Can we determine key influencer based on retweets?

# Primary reference: "Demo of RNeo4j Part 1: Building a Database" by Nicole White
# http://nicolewhite.github.io/r/2014/05/30/demo-of-rneo4j-part1.html

#install.packages("devtools")
#devtools::install_github("nicolewhite/RNeo4j")
library(RNeo4j)

graph = startGraph("http://localhost:7474/db/data/", username = "neo4j", password = "msda16")
clear(graph)
Y

# ensure names are unique
addConstraint(graph, "Name", "name")

load("favorites_dataset.Rda")
load("followers_dataset.Rda")

# Followers

add.rel.followers <- function(flwr, user){
  user = getOrCreateNode(graph, "Name", name=user)
  flwr = getOrCreateNode(graph, "Name", name=flwr)
  createRel(flwr, "FOLLOWS", user)}

users <- names(followers)

for (i in 1:length(users)){
  a <- lapply(unlist(unname(followers[i])), FUN = add.rel.followers, user = users[i])}

# Favorites - runs slow
add.rel.favorites <- function(flwr, user){
  user = getOrCreateNode(graph, "Name", name=user)
  flwr = getOrCreateNode(graph, "Name", name=flwr)
  createRel(flwr, "FAVORITED", user)}

users.fav <- names(favorites)

for (i in 1:length(users)){
  a <- lapply(unlist(unname(favorites[i])), FUN = add.rel.favorites, user = users.fav[i])}

