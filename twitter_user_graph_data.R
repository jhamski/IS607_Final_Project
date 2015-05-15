# IS607 Data Acquisition and Management | CUNY MS Data Analytics | James Hamski

# Project Goal: create a social graph of the R Stats community on Twitter
# Can we find different domain groups (i.e. biostats, finance)?
# Can we determine key influencer based on retweets?

library(twitteR)
library(dplyr)

# Keys stored in a txt file and kept out of Github repo
key <- scan("api_key.txt", what="charsacter")


#Who uses the #RStats hashtag the most?
r.stats.search <- searchTwitter("#Rstats", n=1000)

r.stats.search%>%
  twListToDF()%>%
  group_by(screenName) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) -> r.stats
  
#Start with Hadley Wickham, well known R Stats package developer/guru
hw <- getUser("hadleywickham") 

#Note this runs very very slow (due to API limits/throtteling? just size?)
hw.friends <-hw$getFollowers()

hw.favorites <-hw$getFavorites()

hw.favorited <- hw$getFavorited(blockOnRateLimit=TRUE)
hw.retweets <- hw$getRetweets(blockOnRateLimit=TRUE)

hw.df<-twListToDF(hw)

#Go back to who uses the RStats hashtag the most



#Create graph for small dummy dataset
#Each list can signify "follows" or "favorited" or "retweeted" (any output that is a username)
sean <- c("nate", "matt", "sara", "pete", "cate", "laura")
laura <- c("maura", "sean", "greg", "matt", "sara")
albert <- c("nate", "sara", "roger", "maura")




#Create graph for real dataset 
