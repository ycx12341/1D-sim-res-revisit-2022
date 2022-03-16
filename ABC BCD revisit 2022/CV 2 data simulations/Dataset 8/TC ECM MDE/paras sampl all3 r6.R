# paras sampl all3 r6.R
# Author: Yunchen Xiao

# This .R file reads in the parameters used in round 6 of the evaluations of all 
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
save.sims.dir <- "BCD_results_all3_r6"
save.sims <- TRUE

if(save.sims) {
  if(!dir.exists(save.sims.dir)) dir.create(save.sims.dir)
}

# Read in the parameters to be evaluated in the current round.
paras.all3.r6 <- as.matrix(read.table("Round 6 parameters 10000 all 3.txt", sep = "",
                                      header = TRUE))

# Set up the parallel running scheme. 
n.thread <- detectCores()/2
n.sims <- 10000
cl <- makeCluster(n.thread)
registerDoParallel(cl)

tic()
ests <- foreach (i = 1:n.sims, .combine = rbind) %dopar% {
  bcd.temp <- bcd(paras = paras.all3.r6[i,], paras.ind = "all_three")
  
  # Optional line: store the results into .rds files.
  readr::write_rds(bcd.temp,
                   path = paste0("./", save.sims.dir, "/Round_6_paras", i, "_res.rds"))
  
  c(i, bcd.temp)
}
toc()

stopCluster(cl)

# 379.279 sec elapsed. 

write.table(ests, "bcd_all3_r6.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has been met! The algorithm is now 
# terminated.
bcd.all3.r6 <- unname(ests)
mean(bcd.all3.r6[,2]) # 0.07698692
min(bcd.all3.r6[,2]) # 0.03534571

(0.07698692 - 3.868389)/3.868389 * 100
# -98.00985

paras.final.est <- apply(paras.all3.r6, 2, mean)
# 0.010000883  0.053248783 10.032820579  0.009894034  0.100118727  5.343235840 
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.final.est - paras.ref)/paras.ref*100
# 0.008833413  6.497566412  0.328205792 -1.059659294  0.118726699  6.864716802 




