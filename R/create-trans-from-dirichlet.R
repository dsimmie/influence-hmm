createTransFromDirichlet <- function(numStates){
  library(gtools)

  row1 <- rdirichlet(1, c(100,10,1,0.1))
  row2 <- rdirichlet(1, c(30,50,10,1))
  row3 <- rdirichlet(1, c(30,20,50,10))
  row4 <- rdirichlet(1, c(10,20,20,30))

  trans <- rbind(row1,row2,row3,row4)
}