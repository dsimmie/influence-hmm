library(Hmisc)
source('create-activity-dataframe.R')
source('add-act.R')

buzz.analysis <- read.csv(paste0(data.path,'buzz-rank-output.csv'))

rowCount <- dim(buzz.analysis)[1]

buzz.analysis$Total.Activity <- integer(rowCount)
buzz.analysis$Active.Weeks <- integer(rowCount)
buzz.analysis$Total.Retweets <- integer(rowCount)
buzz.analysis$Retweeted.Weeks <- integer(rowCount)
buzz.analysis$Total.Mentions <- integer(rowCount)
buzz.analysis$Mentioned.Weeks <- integer(rowCount)
buzz.analysis$Total.Unique.Interactions <- integer(rowCount)
buzz.analysis$Conversation.Weeks <- integer(rowCount)

calc.activity <- function(x) list(x[1], sum(as.numeric(x[2:44])), sum(as.numeric(x[2:44])>0))

activity.list <- apply(tpw,1,calc.activity)
rt.activity.list <- apply(lab.rtpw, 1, calc.activity)
mt.activity.list <- apply(lab.mtpw, 1, calc.activity)
ui.activity.list <- apply(lab.uipw, 1, calc.activity)

activity.df <- createActivityDataFrame(activity.list)
rt.activity.df <- createActivityDataFrame(rt.activity.list)
mt.activity.df <- createActivityDataFrame(mt.activity.list)
ui.activity.df <- createActivityDataFrame(ui.activity.list)

buzz.analysis <- addActivity(buzz.analysis, activity.df, "Total.Activity","Active.Weeks")
buzz.analysis <- addActivity(buzz.analysis, rt.activity.df, "Total.Retweets","Retweeted.Weeks")
buzz.analysis <- addActivity(buzz.analysis, mt.activity.df, "Total.Mentions","Mentioned.Weeks")
buzz.analysis <- addActivity(buzz.analysis, ui.activity.df, "Total.Unique.Interactions","Conversation.Weeks")

rm(calc.activity)
rm(activity.list)
rm(rt.activity.list)
rm(mt.activity.list)
rm(ui.activity.list)
rm(activity.df)
rm(rt.activity.df)
rm(mt.activity.df)
rm(ui.activity.df)

write.csv(buzz.analysis, paste0(data.path, 'complete-buzz-rank.csv'))

influence.analysis <- buzz.analysis
# Add influence variable.
influence.analysis$Influence <- (buzz.analysis$Reach * buzz.analysis$Buzz)
# Re-order columns.
influence.analysis <- influence.analysis[c("Ident","Influence","Reach","Buzz","In.Deg","Total.Activity","Active.Weeks","Total.Retweets","Retweeted.Weeks","Total.Mentions","Mentioned.Weeks","Total.Unique.Interactions","Conversation.Weeks")]
# Order by the influence column
order.idx <- which(names(influence.analysis)=="Influence")
influence.analysis <- influence.analysis[ order(-influence.analysis[ ,order.idx]), ]

write.csv(influence.analysis, paste0(data.path, 'complete-influence-rank.csv'))