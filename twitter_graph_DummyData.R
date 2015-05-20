# IS607 Data Acquisition and Management | CUNY MS Data Analytics | James Hamski
#Create graph for small dummy dataset for planning purposes

# WORKS

library(RNeo4j)


#Each list can signify "follows" or "favorited" or "retweeted" (any output that is a username)
sean <- c("nate", "matt", "sara", "pete", "cate", "laura")
laura <- c("maura", "sean", "greg", "matt", "sara")
albert <- c("nate", "sara", "roger", "maura")
follows <-c("sean","laura","albert")

#Create graph for real dataset 
#Connect to Neo4j after starting the server at the command line. Note that you may need to change the password 
#in the Neo4j console before moving on. 

graph = startGraph("http://localhost:7474/db/data/", username = "neo4j", password = "msda16")
clear(graph)

# ensure names are unique
addConstraint(graph, "Name", "name")

# create relationships
# Relationship without properties.
add.rel <- function(flwr, user){
  user = getOrCreateNode(graph, "Name", name=user)
  flwr = getOrCreateNode(graph, "Name", name=flwr)
  createRel(flwr, "FOLLOWS", user)}

user <- "sean"
a <- lapply(sean, FUN = add.rel, user = user)

user <- "laura"
a <- lapply(laura, FUN = add.rel, user = user)

user <- "albert"
a <- lapply(laura, FUN = add.rel, user = user)
