addActivity <- function(analysis.df, act.df, var1, var2){ 
  rowCount = dim(analysis.df)[1]
  
  idx1 <- which(names(analysis.df)==var1)
  idx2 <- which(names(analysis.df)==var2)
  
  for(i in 1:rowCount){
    act.row <- act.df[act.df$Name==as.character(analysis.df[i,1]), ] 
    analysis.df[i,idx1] <- act.row[1,2]
    analysis.df[i,idx2] <- act.row[1,3]
  }
  
  return(analysis.df)
}