createActivityDataFrame <- function(act.sum){
  rowCount <- length(act.sum)
  df = data.frame(Name=character(rowCount),Total.Activity=integer(rowCount),Active.Days=integer(rowCount),stringsAsFactors=FALSE)
  for(i in 1:rowCount){
    df[i,1] = as.character(act.sum[[i]][1])
    df[i,2:3] = c(act.sum[[i]][2],act.sum[[i]][3])
  }
  
  return(df)
}