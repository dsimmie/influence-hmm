# Create the four stats transition matrix for the Buzz HMM.
# Each row is created from a Dirichlet distribution with different alpha shape parameters.
# The values of the shape parameters are chosen from our prior knowledge of the Buzz problem.

createTransFromDirichlet <- function(){
  library(gtools)

  row1 <- rdirichlet(1, c(100,10,1,0.1))
  row2 <- rdirichlet(1, c(30,50,10,1))
  row3 <- rdirichlet(1, c(30,20,50,10))
  row4 <- rdirichlet(1, c(10,20,20,30))

  return(rbind(row1,row2,row3,row4))
}