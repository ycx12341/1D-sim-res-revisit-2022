# Post_process.R
# This .R file reads in the final parameter samples for each perturbed dataset
# and calculates the sample mean for each parameter, which are taken as the final
# parameter estimates. 

# Set the workspace
rm(list = ls())

# Read in all the final parameter samples
paras.final.ds1 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 1.txt", 
                                        sep = "", header = TRUE))
paras.final.ds2 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 2.txt", 
                                        sep = "", header = TRUE))
paras.final.ds3 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 3.txt", 
                                        sep = "", header = TRUE))
paras.final.ds4 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 4.txt", 
                                        sep = "", header = TRUE))
paras.final.ds5 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 5.txt", 
                                        sep = "", header = TRUE))
paras.final.ds6 <- as.matrix(read.table("Round 9 parameters 10000 all 3 dataset 6.txt", 
                                        sep = "", header = TRUE))
paras.final.ds7 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 7.txt", 
                                        sep = "", header = TRUE))
paras.final.ds8 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 8.txt", 
                                        sep = "", header = TRUE))
paras.final.ds9 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 9.txt", 
                                        sep = "", header = TRUE))
paras.final.ds10 <- as.matrix(read.table("Round 10 parameters 10000 all 3 dataset 10.txt", 
                                        sep = "", header = TRUE))

# Calculate the sample means for each parameter.
paras.ests.ds1 <- apply(paras.final.ds1, 2, mean)
paras.ests.ds2 <- apply(paras.final.ds2, 2, mean)
paras.ests.ds3 <- apply(paras.final.ds3, 2, mean)
paras.ests.ds4 <- apply(paras.final.ds4, 2, mean)
paras.ests.ds5 <- apply(paras.final.ds5, 2, mean)
paras.ests.ds6 <- apply(paras.final.ds6, 2, mean)
paras.ests.ds7 <- apply(paras.final.ds7, 2, mean)
paras.ests.ds8 <- apply(paras.final.ds8, 2, mean)
paras.ests.ds9 <- apply(paras.final.ds9, 2, mean)
paras.ests.ds10 <- apply(paras.final.ds10, 2, mean)

# Final parameter estimates
paras.ests.final <- rbind(paras.ests.ds1, paras.ests.ds2, paras.ests.ds3,
                          paras.ests.ds4, paras.ests.ds5, paras.ests.ds6,
                          paras.ests.ds7, paras.ests.ds8, paras.ests.ds9,
                          paras.ests.ds10)
colnames(paras.ests.final) <- c("dn", "gamma", "eta", "dm", "alpha", "rn")
write.table(paras.ests.final, "CV 5 average parameter estimates.txt")

paras.ests.final.avg <- apply(paras.ests.final, 2, mean)
# 0.008531851  0.054080504 10.158242008  0.010063896  0.101089114  4.571845347 

# Error rates
paras.ref <- c(0.01, 0.05, 10, 0.01, 0.1, 5)
(paras.ests.final.avg - paras.ref)/paras.ref * 100
# -14.6814892   8.1610085   1.5824201   0.6389567   1.0891142  -8.5630931 
