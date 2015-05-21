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

r.stats.search %>%
  twListToDF() %>%
  group_by(screenName) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) -> r.stats

##########
# For development/testing, start with Hadley Wickham, well known R Stats package developer/guru 
hw <- getUser("hadleywickham") 

# Followers
#runs slow unless limited by setting n
hw.followers <-hw$getFollowers(n=500)

# Save to ensure DF can be used between sessions even if the env is cleared
save(hw.followers, file="HW_followers.Rda")

# Favorites
hw.favorites <-hw$getFavorites(n=200)
save(hw.favorites, file="HW_favorites.Rda")
##########


# Iterate through list of top tweeters, then pull their followers and who they favorite
# This will run very slow again, may run into API call limits

twit.list <- r.stats$screenName[1:5]

#twit.list.test <- r.stats$screenName[1:2]

get.followers <-function(screenName){
  user <- getUser(screenName)
  followers <- user$getFollowers()
  followers<-twListToDF(followers)
  followers <- followers$screenName
  return(followers)
      }

followers <- lapply(twit.list, FUN = get.followers)
followers <- as.data.frame(followers)
colnames(followers) <- twit.list
save(followers, file="followers_dataset.Rda")

get.favorites <-function(screenName){
  user <- getUser(screenName)
  favorites <- user$getFavorites(n=200)
  favorites<-twListToDF(favorites)
  favorites <- favorites$screenName
  return(favorites)
      }

favorites <- lapply(twit.list, FUN = get.favorites)
favorites <- as.data.frame(favorites)
colnames(favorites) <- twit.list
save(favorites, file="favorites_dataset.Rda")
