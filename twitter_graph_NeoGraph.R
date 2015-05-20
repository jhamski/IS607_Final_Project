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


#Create graph for small dummy dataset 
#Each list can signify "follows" or "favorited" or "retweeted" (any output that is a username)
sean <- c("nate", "matt", "sara", "pete", "cate", "laura")
laura <- c("maura", "sean", "greg", "matt", "sara")
albert <- c("nate", "sara", "roger", "maura")

#Create graph for real dataset 
#Connect to Neo4j after starting the server at the command line. Note that you may need to change the password 
#in the Neo4j console before moving on. 

graph = startGraph("http://localhost:7474/db/data/", username = "neo4j", password = "msda16")
clear(graph)
