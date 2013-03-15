rawpath <- '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/data/shared/data/new-model/raw/'
procpath <- '/Users/dsimmie/Dropbox/research/Imperial/influence-evo/data/shared/data/new-model/processed/'
rtpwpath <- paste0(rawpath,'retweets_per_week.csv')
mtpwpath <- paste0(rawpath,'mentions_per_week.csv')
uipwpath <- paste0(rawpath,'unique_interactions_per_week.csv')
tpwpath <- paste0(rawpath,'tweets_per_week.csv')

norm.rtpwpath <- paste0(procpath,'buzz_norm_retweets_per_week.csv')
norm.mtpwpath <- paste0(procpath,'buzz_norm_mentions_per_week.csv')
norm.uipwpath <- paste0(procpath,'buzz_norm_unique_interactions_per_week.csv')

rtpw <- read.csv(rtpwpath, colClasses=c('NULL', rep('numeric', 43)))
mtpw <- read.csv(mtpwpath, colClasses=c('NULL', rep('numeric', 43)))
uipw <- read.csv(uipwpath, colClasses=c('NULL', rep('numeric', 43)))
tpw <- read.csv(tpwpath)
lab.tpw = tpw[ ,1:44]
tpw <- tpw[ ,2:44]

norm.rtpw <- read.csv(norm.rtpwpath, colClasses=c('NULL', rep('numeric', 43)))
norm.mtpw <- read.csv(norm.mtpwpath, colClasses=c('NULL', rep('numeric', 43)))
norm.uipw <- read.csv(norm.uipwpath, colClasses=c('NULL', rep('numeric', 43)))