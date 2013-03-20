data.path <- '~/data/'
rtpwpath <- paste0(data.path,'retweets_per_week.csv')
mtpwpath <- paste0(data.path,'mentions_per_week.csv')
uipwpath <- paste0(data.path,'unique_interactions_per_week.csv')
tpwpath <- paste0(data.path,'tweets_per_week.csv')

lab.rtpw <- read.csv(rtpwpath)
lab.mtpw <- read.csv(mtpwpath)
lab.uipw <- read.csv(uipwpath)

rtpw <- lab.rtpw[2:dim(lab.rtpw)[1], 2:dim(lab.rtpw)[2]]
mtpw <- lab.mtpw[2:dim(lab.mtpw)[1], 2:dim(lab.mtpw)[2]]
uipw <- lab.uipw[2:dim(lab.uipw)[1], 2:dim(lab.uipw)[2]]

tpw <- read.csv(tpwpath)
lab.tpw = tpw[ ,1:44]
tpw <- tpw[ ,2:44]

tmp.buzz <- read.csv(paste0(data.path,'buzz-temporal-output.csv'))

obs.dates <- names(rtpw)[1:43]

names(tmp.buzz)[1] <- "Ident"
names(tmp.buzz)[2:44] <- obs.dates