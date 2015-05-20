# IS607 Data Acquisition and Management | CUNY MS Data Analytics | James Hamski
# Script 1 - acquire data from the Twitter API, save to local directory

# Project Goal: create a social graph of the R Stats community on Twitter
# Can we find different domain groups (i.e. biostats, finance)?
# Can we determine key influencer based on retweets?

library(twitteR)
library(dplyr)


# Keys stored in a txt file and kept out of Github repo
key <- scan("api_key.txt", what="charsacter")

consumer_key <- key[1]
consumer_secret <- key[2]
access_token <- key[3]
access_secret <- key[4]
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

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




