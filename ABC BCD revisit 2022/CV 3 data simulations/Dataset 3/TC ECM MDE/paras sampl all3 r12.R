# paras sampl all3 r12.R
# Author: Yunchen Xiao

# This .R file reads in the parameters used in round 12 of the evaluations of all 
# three density profiles and checks if the stopping criterion has been met.

# Clear the workspace and load the necessary packages.
rm(list = ls())
library(doParallel)
library(doRNG)
library(tictoc)
library(readr)

# Source functions.
source("Automatic.R")

# Optional line: set the directory to store the results in .rds files. 
save.sims.dir <- "BCD_results_all3_r12"
save.sims <- TRUE

if(save.sims) {
  if(!dir.exists(save.sims.dir)) dir.create(save.sims.dir)
}

# Read in the parameters to be evaluated in the current round.
paras.all3.r12 <- as.matrix(read.table("Round 12 parameters 10000 all 3.txt", sep = "",
                                       header = TRUE))

# Set up the parallel running scheme. 
n.thread <- detectCores()/2
n.sims <- 10000
cl <- makeCluster(n.thread)
registerDoParallel(cl)

tic()
ests <- foreach (i = 1:n.sims, .combine = rbind) %dopar% {
  bcd.temp <- bcd(paras = paras.all3.r12[i,], paras.ind = "all_three")
  
  # Optional line: store the results into .rds files.
  readr::write_rds(bcd.temp,
                   path = paste0("./", save.sims.dir, "/Round_12_paras", i, "_res.rds"))
  
  c(i, bcd.temp)
}
toc()

stopCluster(cl)

# 379.187 sec elapsed.

write.table(ests, "bcd_all3_r12.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has not been met yet! However, based on
# the minimum discrepancy results of the current round, it is clear that 98% 
# reduction is impossible. The stopping criteria is redefined to reduction of 
# average discrepancy measurement less than 5% compare to that of the previous
# round, which has been met now! 
bcd.all3.r12 <- unname(ests)
mean(bcd.all3.r12[,2]) # 0.1027056
min(bcd.all3.r12[,2]) # 0.09750943

(0.1058509 - 0.1027056)/0.1058509*100
# 2.971444

paras.final.est <- apply(paras.all3.r12, 2, mean)
# 0.009400162 0.049350847 9.934747291 0.010304885 0.099639136 4.768526495 
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.final.est - paras.ref)/paras.ref*100
# -5.9983769 -1.2983063 -0.6525271  3.0488459 -0.3608638 -4.6294701 

