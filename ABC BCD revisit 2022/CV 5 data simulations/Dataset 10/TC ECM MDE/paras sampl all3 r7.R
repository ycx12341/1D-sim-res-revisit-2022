# paras sampl all3 r7.R
# Author: Yunchen Xiao

# This .R file reads in the parameters used in round 7 of the evaluations of all 
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
save.sims.dir <- "BCD_results_all3_r7"
save.sims <- TRUE

if(save.sims) {
  if(!dir.exists(save.sims.dir)) dir.create(save.sims.dir)
}

# Read in the parameters to be evaluated in the current round.
paras.all3.r7 <- as.matrix(read.table("Round 7 parameters 10000 all 3.txt", sep = "",
                                      header = TRUE))

# Set up the parallel running scheme. 
n.thread <- detectCores()/2
n.sims <- 10000
cl <- makeCluster(n.thread)
registerDoParallel(cl)

tic()
ests <- foreach (i = 1:n.sims, .combine = rbind) %dopar% {
  bcd.temp <- bcd(paras = paras.all3.r7[i,], paras.ind = "all_three")
  
  # Optional line: store the results into .rds files.
  readr::write_rds(bcd.temp,
                   path = paste0("./", save.sims.dir, "/Round_7_paras", i, "_res.rds"))
  
  c(i, bcd.temp)
}
toc()

stopCluster(cl)

# 377.468 sec elapsed. 

write.table(ests, "bcd_all3_r7.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has not been met yet!
bcd.all3.r7 <- unname(ests)
ind.nan.all3.r7 <- which(is.na(bcd.all3.r7[,2]))
bcd.all3.r7.valid <- bcd.all3.r7[-ind.nan.all3.r7,]
mean(bcd.all3.r7.valid[,2]) # 0.7274696
min(bcd.all3.r7.valid[,2]) # 0.5676342

# Resample and record the parameter values to be evaluated in the next round. 
set.seed(123)
RNGkind(sample.kind = "Rejection")
paras.all3.r8 <- abc.bcd(ss.mat = bcd.all3.r7, paras = paras.all3.r7, bw = 5.695312)
write.table(paras.all3.r8, "Round 8 parameters 10000 all 3.txt")