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

