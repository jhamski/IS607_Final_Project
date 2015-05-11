# IS607 Data Acquisition and Management | CUNY MS Data Analytics | James Hamski

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
hw.friends <-friendships("hadleywickham", n=1000)
hw.favorites <- favorites("hadleywickham", n=100)
hw.retweets <- retweets("hadleywickham", n=100)

twListToDF(twList)