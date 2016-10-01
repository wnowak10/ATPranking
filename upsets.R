library(ggplot2)

# use ATP tennis ranking data from kaggle

Data = read.csv("/Users/wnowak/Desktop/Data.csv")
head(Data)


Data$WRank = as.numeric(Data$WRank)
Data$LRank = as.numeric(Data$LRank)

ggplot(Data,aes(Data$WRank))+
  geom_histogram()

# make top seed which is rank of higher player
Data$BetterRank= ifelse(Data$WRank < Data$LRank, Data$WRank, Data$LRank) 
# 1 means an upset
Data$Upset <- ifelse(Data$WRank > Data$LRank, 1, 0) 

ggplot(Data, aes(x=BetterRank, y=Upset))+
  geom_smooth()+
  labs(title="Upsets are most common when the top player is of middling rank")


mean(Data[Data$Round=="1st Round",]$Upset)
mean(Data[Data$Round=="2nd Round",]$Upset)
mean(Data[Data$Round=="3rd Round",]$Upset)
mean(Data[Data$Round=="4th Round",]$Upset)
mean(Data[Data$Round=="Semifinals",]$Upset)
mean(Data[Data$Round=="The Final",]$Upset)

require(reshape2)

plot.data <- melt(tapply(Data$Upset, Data$Round,mean,na.rm=T), varnames="group", value.name="mean")
plot.data=plot.data[-1,]
ggplot(plot.data, aes(x=group,y=mean)) + geom_bar(position="dodge", stat="identity")
