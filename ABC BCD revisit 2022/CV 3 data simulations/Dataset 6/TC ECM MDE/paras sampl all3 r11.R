# paras sampl all3 r11.R
# Author: Yunchen Xiao

# This .R file reads in the parameters used in round 11 of the evaluations of all 
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
save.sims.dir <- "BCD_results_all3_r11"
save.sims <- TRUE

if(save.sims) {
  if(!dir.exists(save.sims.dir)) dir.create(save.sims.dir)
}

# Read in the parameters to be evaluated in the current round.
paras.all3.r11 <- as.matrix(read.table("Round 11 parameters 10000 all 3.txt", sep = "",
                                       header = TRUE))

# Set up the parallel running scheme. 
n.thread <- detectCores()/2
n.sims <- 10000
cl <- makeCluster(n.thread)
registerDoParallel(cl)

tic()
ests <- foreach (i = 1:n.sims, .combine = rbind) %dopar% {
  bcd.temp <- bcd(paras = paras.all3.r11[i,], paras.ind = "all_three")
  
  # Optional line: store the results into .rds files.
  readr::write_rds(bcd.temp,
                   path = paste0("./", save.sims.dir, "/Round_11_paras", i, "_res.rds"))
  
  c(i, bcd.temp)
}
toc()

stopCluster(cl)

# 374.945 sec elapsed.

write.table(ests, "bcd_all3_r11.txt")

# Calculate and record the average summary statistics of the parameters in the 
# current round, the stopping criterion (98% reduction in the average summary
# statistics of the initial parameters) has not been met yet! However, based on
# the minimum discrepancy results of the current round, it is clear that 98% 
# reduction is impossible. The stopping criteria is redefined to reduction of 
# average discrepancy measurement less than 5% compare to that of the previous
# round, which has been met now! 
bcd.all3.r11 <- unname(ests)
mean(bcd.all3.r11[,2]) # 0.135953
min(bcd.all3.r11[,2]) # 0.1287914

(0.1406337 - 0.135953)/0.1406337*100
# 3.328292

paras.final.est <- apply(paras.all3.r11, 2, mean)
# 0.012212315 0.049425876 9.863256558 0.009443051 0.099931052 4.774105410 
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.final.est - paras.ref)/paras.ref*100
# 22.12315439 -1.14824711 -1.36743442 -5.56949482 -0.06894842 -4.51789179 

