addReachToBuzz <- function(influence.analysis, temporal.buzz){
  
    rowCount = dim(temporal.buzz)[1]
    # Ignore the row name
    obsCount = dim(temporal.buzz)[2]-1
    
    reachIdx <- which(names(influence.analysis)=="Reach")
    temporal.influence <- temporal.buzz
    
    for(i in 1:rowCount){
      # Get the reach for this user
      temporal.user <- as.character(temporal.buzz[i,1])
      
      reach <- influence.analysis[influence.analysis$Ident==temporal.user, reachIdx] 
      
      temporal.influence[i, 1] <- temporal.buzz[i,1]
      
      # Apply the reach vector-wise to each of the buzz entries.
      # Note: Indexing is exclusive so add 1 to observation count.
      endRange <- (obsCount+1)
      temporal.influence[i, 2:endRange] <- temporal.buzz[i, 2:endRange] * reach
    }
    
    return(temporal.influence)
}