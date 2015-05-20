# IS607 Data Acquisition and Management | CUNY MS Data Analytics | James Hamski
# Script 2 - clean data from the Twitter API


load("HW_followers.Rda")
hw.df<-twListToDF(hw.followers)
hw.followers <- hw.df$screenName
