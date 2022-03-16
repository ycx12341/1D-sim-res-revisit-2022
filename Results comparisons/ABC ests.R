# ABC ests.R
# Author: Yunchen Xiao
# This .R file reads in the ABC parameter estimates in the end of different runs 
# and under different levels of perturbations. Average across the different runs
# for each CV and write them into a single .txt file. 

# Clear the current workspace
rm(list = ls())

# Read in the ABC parameter estimates in the end of different runs under each 
# level of perturbation. 
paras.abc.cv1 <- as.matrix(read.table("CV 1 average parameter estimates.txt", 
                                      sep = "", header = TRUE))
paras.abc.cv2 <- as.matrix(read.table("CV 2 average parameter estimates.txt", 
                                      sep = "", header = TRUE))
paras.abc.cv3 <- as.matrix(read.table("CV 3 average parameter estimates.txt", 
                                      sep = "", header = TRUE))
paras.abc.cv4 <- as.matrix(read.table("CV 4 average parameter estimates.txt", 
                                      sep = "", header = TRUE))
paras.abc.cv5 <- as.matrix(read.table("CV 5 average parameter estimates.txt", 
                                      sep = "", header = TRUE))

# Compute the average ABC parameter estimates for each level of perturbation. 
paras.avg.abc.cv1 <- apply(paras.abc.cv1, 2, mean)
paras.avg.abc.cv2 <- apply(paras.abc.cv2, 2, mean)
paras.avg.abc.cv3 <- apply(paras.abc.cv3, 2, mean)
paras.avg.abc.cv4 <- apply(paras.abc.cv4, 2, mean)
paras.avg.abc.cv5 <- apply(paras.abc.cv5, 2, mean)

# Write the average ABC parameter estimates into a single .txt file. 
paras.avg.5cv <- rbind(paras.avg.abc.cv1, paras.avg.abc.cv2, paras.avg.abc.cv3,
                       paras.avg.abc.cv4, paras.avg.abc.cv5)
write.table(paras.avg.5cv, "Parameter estimates 5 cv abc.txt")
