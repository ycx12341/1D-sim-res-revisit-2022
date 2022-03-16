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

# 378.66 sec elapsed. 

write.table(ests, "bcd_all3_r5.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has not been met yet!
bcd.all3.r5 <- unname(ests)
ind.nan.all3.r5 <- which(is.na(bcd.all3.r5[,2]))
bcd.all3.r5.valid <- bcd.all3.r5[-ind.nan.all3.r5,]
mean(bcd.all3.r5.valid[,2]) # 0.2923901
min(bcd.all3.r5.valid[,2]) # 0.1379777

# Resample and record the parameter values to be evaluated in the next round. 
set.seed(123)
RNGkind(sample.kind = "Rejection")
paras.all3.r6 <- abc.bcd(ss.mat = bcd.all3.r5, paras = paras.all3.r5, bw = 2.53125)
write.table(paras.all3.r6, "Round 6 parameters 10000 all 3.txt")
