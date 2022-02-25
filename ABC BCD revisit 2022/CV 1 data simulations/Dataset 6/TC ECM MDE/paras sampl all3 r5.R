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

# 373.657 sec elapsed. 

write.table(ests, "bcd_all3_r5.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has been met! The algorithm is now 
# terminated.
bcd.all3.r5 <- unname(ests)
ind.nan.all3.r5 <- which(is.na(bcd.all3.r5[,2]))
bcd.all3.r5.valid <- bcd.all3.r5[-ind.nan.all3.r5,]
mean(bcd.all3.r5.valid[,2]) # 0.06597957
min(bcd.all3.r5.valid[,2]) # 0.0150361

(0.06597957 - 3.71839)/3.71839*100
# -98.22559

paras.final.est <- apply(paras.all3.r5, 2, mean)
# 0.01044409  0.05031574 10.09385697  0.01000927  0.10064872  5.09294998 
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.final.est - paras.ref)/paras.ref*100
# 4.44090101 0.63147596 0.93856973 0.09266254 0.64872245 1.85899953 

