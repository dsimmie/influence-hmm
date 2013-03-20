source('load-influence-data.R')
source('add-reach-to-buzz.R')
source('create-buzz-analysis-df.R')

tmp.influence <- addReachToBuzz(buzz.analysis, tmp.buzz)
ranked.users <- rankTimeSeriesUsers(tmp.influence, obs.dates, 1, FALSE)

write.csv(tmp.influence, paste0(data.path, 'influence-temporal.csv'))
write.csv(ranked.users, paste0(data.path, 'influence-ranked-temporal.csv'))