getId <- function(combinedIdentifier){
  l <- str_split(combinedIdentifier, '_')
  return(as.integer(l[[1]][length(l[[1]])]))
}