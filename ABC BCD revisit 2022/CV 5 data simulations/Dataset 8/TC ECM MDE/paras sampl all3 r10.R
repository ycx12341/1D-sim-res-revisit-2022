# paras sampl all3 r10.R
# Author: Yunchen Xiao

# This .R file reads in the parameters used in round 10 of the evaluations of all 
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
save.sims.dir <- "BCD_results_all3_r10"
save.sims <- TRUE

if(save.sims) {
  if(!dir.exists(save.sims.dir)) dir.create(save.sims.dir)
}

# Read in the parameters to be evaluated in the current round.
paras.all3.r10 <- as.matrix(read.table("Round 10 parameters 10000 all 3.txt", sep = "",
                                      header = TRUE))

# Set up the parallel running scheme. 
n.thread <- detectCores()/2
n.sims <- 10000
cl <- makeCluster(n.thread)
registerDoParallel(cl)

tic()
ests <- foreach (i = 1:n.sims, .combine = rbind) %dopar% {
  bcd.temp <- bcd(paras = paras.all3.r10[i,], paras.ind = "all_three")
  
  # Optional line: store the results into .rds files.
  readr::write_rds(bcd.temp,
                   path = paste0("./", save.sims.dir, "/Round_10_paras", i, "_res.rds"))
  
  c(i, bcd.temp)
}
toc()

stopCluster(cl)

# 376.304 sec elapsed.

write.table(ests, "bcd_all3_r10.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has not been met yet! However, based on
# the minimum discrepancy results of the current round, it is clear that 98% 
# reduction is impossible. The stopping criteria is redefined to reduction of 
# average discrepancy measurement less than 5% compare to that of the previous
# round, which has been met now! 
bcd.all3.r10 <- unname(ests)
ind.nan.all3.r10 <- which(is.na(bcd.all3.r10[,2]))
bcd.all3.r10.valid <- bcd.all3.r10[-ind.nan.all3.r10,]
mean(bcd.all3.r10.valid[,2]) # 0.5676055
min(bcd.all3.r10.valid[,2]) # 0.5302961

(0.5880651 - 0.5676055)/0.5880651*100
# 3.479139

paras.final.est <- apply(paras.all3.r10, 2, mean)
# 0.009968170  0.051503384 10.120217880  0.009901137  0.101409373  4.332996453 
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.final.est - paras.ref)/paras.ref*100
# -0.3182986   3.0067675   1.2021788  -0.9886291   1.4093730 -13.3400709 









