rankTimeSeriesUsers <- function(tmp.influence, obs.dates, nprct, trimName){
  
row.count <- dim(tmp.influence)[1]
obs.count <- dim(tmp.influence)[2]

oneprct <- as.integer(row.count/100)

sample.size <- oneprct * nprct

df = data.frame(setNames(replicate((obs.count-1),character(sample.size), simplify = F), obs.dates))

for(i in 2:obs.count){
  influence <- tmp.influence[ order(-tmp.influence[,i]), ]
  top.n.names <- influence[1:sample.size,1]
  
  if(trimName){
    df[ ,i-1] = sapply(top.n.names, getId)
  }
  else{
    df[ ,i-1] = top.n.names
  }
}

return(df)
}
