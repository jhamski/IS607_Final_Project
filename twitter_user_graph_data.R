
library(twitteR)

key <- scan("api_key.txt", what="charsacter")

consumer_key <- key[1]
consumer_secret <- key[2]
access_token <- key[3]
access_secret <- key[4]
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

r_stats <- searchTwitter("#Rstats", n=1500)