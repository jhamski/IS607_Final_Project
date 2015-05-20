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
  
# Start with Hadley Wickham, well known R Stats package developer/guru
hw <- getUser("hadleywickham") 

# Followers
# Note this runs very very slow (due to API limits/throtteling? just size?)
hw.followers <-hw$getFollowers(n=500)
# Save to ensure DF can be used between sessions even if the env is cleared
save(hw.followers, file="HW_followers.Rda")


# Favorites
hw.favorites <-hw$getFavorites(n=500)

# Retweets
hw.retweets <- hw$getRetweets(n=500)


hw.favorited <- hw$getFavorited(blockOnRateLimit=TRUE)

