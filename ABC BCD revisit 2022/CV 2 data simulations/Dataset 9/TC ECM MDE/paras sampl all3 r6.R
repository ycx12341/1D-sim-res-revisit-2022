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

# 379.855 sec elapsed. 

write.table(ests, "bcd_all3_r6.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has been met! The algorithm is now 
# terminated.
bcd.all3.r6 <- unname(ests)
ind.nan.all3.r6 <- which(is.na(bcd.all3.r6[,2]))
bcd.all3.r6.valid <- bcd.all3.r6[-ind.nan.all3.r6,]
mean(bcd.all3.r6.valid[,2]) # 0.07327427
min(bcd.all3.r6.valid[,2]) # 0.03654376

(0.07327427 - 3.834041)/3.834041 * 100
# -98.08885

paras.final.est <- apply(paras.all3.r6, 2, mean)
# 0.009969119 0.055363872 9.921195874 0.009914626 0.099470212 5.411020592 
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.final.est - paras.ref)/paras.ref*100
# -0.3088135 10.7277441 -0.7880413 -0.8537413 -0.5297876  8.2204118 





