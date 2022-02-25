# paras sampl all3 r5.R
# Author: Yunchen Xiao

# This .R file reads in the parameters used in round 5 of the evaluations of all 
# three density profiles and checks if the stopping criterion has been met.

# Clear the workspace and load the necessary packages.
rm(list = ls())
library(doParallel)
library(doRNG)
library(tictoc)
library(readr)
library(reshape2)
library(ggplot2)

# Source functions.
source("Automatic.R")

# Optional line: set the directory to store the results in .rds files. 
save.sims.dir <- "BCD_results_all3_r5"
save.sims <- TRUE

if(save.sims) {
  if(!dir.exists(save.sims.dir)) dir.create(save.sims.dir)
}

# Read in the parameters to be evaluated in the current round.
paras.all3.r5 <- as.matrix(read.table("Round 5 parameters 10000 all 3.txt", sep = "",
                                      header = TRUE))

# Set up the parallel running scheme. 
n.thread <- detectCores()/2
n.sims <- 10000
cl <- makeCluster(n.thread)
registerDoParallel(cl)

tic()
ests <- foreach (i = 1:n.sims, .combine = rbind) %dopar% {
  bcd.temp <- bcd(paras = paras.all3.r5[i,], paras.ind = "all_three")
  
  # Optional line: store the results into .rds files.
  readr::write_rds(bcd.temp,
                   path = paste0("./", save.sims.dir, "/Round_5_paras", i, "_res.rds"))
  
  c(i, bcd.temp)
}
toc()

stopCluster(cl)

# 378.392 sec elapsed. 

write.table(ests, "bcd_all3_r5.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has been met! The algorithm is now 
# terminated.
bcd.all3.r5 <- unname(ests)
mean(bcd.all3.r5[,2]) # 0.02436459
min(bcd.all3.r5[,2]) # 0.006833262

(0.02436459 - 3.664989)/3.664989*100
# -99.33521

paras.final.est <- apply(paras.all3.r5, 2, mean)
#  0.010994407  0.049536075 10.008133613  0.009888083  0.099803262  5.029838416 
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.final.est - paras.ref)/paras.ref*100
# 9.94406754 -0.92785054  0.08133613 -1.11917274 -0.19673755  0.59676831 

