# Post_process.r
# Author: Yunchen Xiao

# This .R file reads in the gradient matching simulation results and calculate
# their error percentage with respect to the reference values. In addition, it
# extracts the SDs calculated with three different methods. (true SDs of 200 
# sets of parameter estimates; mean of analytical SDs obtained using inverse 
# Hessian for each perturbed dataset; SDs obtained using non-parametric 
# bootstrap)

# Read in the necessary packages
library(readr)
library(latex2exp)

# Directories that contain the simulation results and boostrap SD calculation
# results.
res.dir <- c("SimRes_ests")
boots.dir <- c("SimRes_boots2")

# Average parameter estimates of 200 perturbed datasets at each CV level. 
cv <- c(0.01, 0.025, 0.05, 0.075, 0.1)
cv.1.res <- read_rds(paste0("./", res.dir, "/cv1_sim_res.rds"))
cv.2.res <- read_rds(paste0("./", res.dir, "/cv2_sim_res.rds"))
cv.3.res <- read_rds(paste0("./", res.dir, "/cv3_sim_res.rds"))
cv.4.res <- read_rds(paste0("./", res.dir, "/cv4_sim_res.rds"))
cv.5.res <- read_rds(paste0("./", res.dir, "/cv5_sim_res.rds"))
cv.1.mean.vals <- apply(cv.1.res$par.ests, 2, mean)
cv.2.mean.vals <- apply(cv.2.res$par.ests, 2, mean)
cv.3.mean.vals <- apply(cv.3.res$par.ests, 2, mean)
cv.4.mean.vals <- apply(cv.4.res$par.ests, 2, mean)
cv.5.mean.vals <- apply(cv.5.res$par.ests, 2, mean)
ests.mat <- rbind(cv.1.mean.vals, cv.2.mean.vals, cv.3.mean.vals,
                  cv.4.mean.vals, cv.5.mean.vals)
write.table(ests.mat, "Parameter estimates 5 cv.txt")

# True SDs of 200 sets of parameter estimates at each CV level.
cv.1.true.sd <- apply(cv.1.res$par.ests, 2, sd)
cv.2.true.sd <- apply(cv.2.res$par.ests, 2, sd)
cv.3.true.sd <- apply(cv.3.res$par.ests, 2, sd)
cv.4.true.sd <- apply(cv.4.res$par.ests, 2, sd)
cv.5.true.sd <- apply(cv.5.res$par.ests, 2, sd)
true.sd.mat <- rbind(cv.1.true.sd, cv.2.true.sd, cv.3.true.sd, cv.4.true.sd,
                     cv.5.true.sd)
write.table(true.sd.mat, "True SD estimates 5 cv.txt")

# Average analytical SDs (obtained using inverse Hessian)of 200 sets of 
# parameter estimates at each CV level.  
cv.1.mean.sd <- apply(cv.1.res$sd.ests, 2, mean)
cv.2.mean.sd <- apply(cv.2.res$sd.ests, 2, mean)
cv.3.mean.sd <- apply(cv.3.res$sd.ests, 2, mean)
cv.4.mean.sd <- apply(cv.4.res$sd.ests, 2, mean)
cv.5.mean.sd <- apply(cv.5.res$sd.ests, 2, mean)
mean.sd.mat <- rbind(cv.1.mean.sd, cv.2.mean.sd, cv.3.mean.sd, cv.4.mean.sd,
                     cv.5.mean.sd)
write.table(mean.sd.mat, "Mean SD estimates 5 cv.txt")

# Bootstrap SDs at each CV level. 
cv1.boots.res <- read_rds(paste0("./", boots.dir, "/cv1_boot_res.rds"))
cv2.boots.res <- read_rds(paste0("./", boots.dir, "/cv2_boot_res.rds"))
cv3.boots.res <- read_rds(paste0("./", boots.dir, "/cv3_boot_res.rds"))
cv4.boots.res <- read_rds(paste0("./", boots.dir, "/cv4_boot_res.rds"))
cv5.boots.res <- read_rds(paste0("./", boots.dir, "/cv5_boot_res.rds"))
cv1.boots.sd <- apply(cv1.boots.res$boot.sd, 2, mean)
cv2.boots.sd <- apply(cv2.boots.res$boot.sd, 2, mean)
cv3.boots.sd <- apply(cv3.boots.res$boot.sd, 2, mean)
cv4.boots.sd <- apply(cv4.boots.res$boot.sd, 2, mean)
cv5.boots.sd <- apply(cv5.boots.res$boot.sd, 2, mean)
boot.sd.mat <- rbind(cv1.boots.sd, cv2.boots.sd, cv3.boots.sd, cv4.boots.sd,
                     cv5.boots.sd)
write.table(boot.sd.mat, "Bootstrap SD estimates 5 cv.txt")

# dn sd comparisons
plot(true.sd.mat[,1], type = "l", lwd = 2, col = "black", 
     ylim = c(min(true.sd.mat[,1], mean.sd.mat[,1], boot.sd.mat[,1]),
              max(true.sd.mat[,1], mean.sd.mat[,1], boot.sd.mat[,1])),
     main = TeX("SD comparisons $d_{n}", bold = TRUE), 
     xlab = "CVs", ylab = "SD")
lines(mean.sd.mat[,1], lwd = 2, col = "blue")
lines(boot.sd.mat[,1], lwd = 2, col = "red")

# gamma sd comparisons
plot(true.sd.mat[,2], type = "l", lwd = 2, col = "black", 
     ylim = c(min(true.sd.mat[,2], mean.sd.mat[,2], boot.sd.mat[,2]),
              max(true.sd.mat[,2], mean.sd.mat[,2], boot.sd.mat[,2])),
     main = TeX("SD comparison $\\gamma$", bold = TRUE), xlab = "CVs", 
     ylab = "SD")
lines(mean.sd.mat[,2], lwd = 2, col = "blue")
lines(boot.sd.mat[,2], lwd = 2, col = "red")

# rn sd comparisons
plot(true.sd.mat[,3], type = "l", lwd = 2, col = "black",
     ylim = c(min(true.sd.mat[,3], mean.sd.mat[,3], boot.sd.mat[,3]),
              max(true.sd.mat[,3], mean.sd.mat[,3], boot.sd.mat[,3])),
     main = TeX("SD comparison $r_{n}$", bold = TRUE), xlab = "CVs",
     ylab = "SD")
lines(mean.sd.mat[,3], lwd = 2, col = "blue")
lines(boot.sd.mat[,3], lwd = 2, col = "red")

# eta sd comparisons
plot(true.sd.mat[,4], type = "l", lwd = 2, col = "black",
     ylim = c(min(true.sd.mat[,4], mean.sd.mat[,4], boot.sd.mat[,4]),
              max(true.sd.mat[,4], mean.sd.mat[,4], boot.sd.mat[,4])),
     main = TeX("SD comparison $\\eta$", bold = TRUE), xlab = "CVs",
     ylab = "SD")
lines(mean.sd.mat[,4], lwd = 2, col = "blue")
lines(boot.sd.mat[,4], lwd = 2, col = "red")

# dm sd comparisons
plot(true.sd.mat[,5], type = "l", lwd = 2, col = "black", 
     ylim = c(min(true.sd.mat[,5], mean.sd.mat[,5], boot.sd.mat[,5]),
              max(true.sd.mat[,5], mean.sd.mat[,5], boot.sd.mat[,5])),
     main = TeX("SD comparison $d_{m}$", bold = TRUE),
     xlab = "CVs", ylab = "SD")
lines(mean.sd.mat[,5], lwd = 2, col = "blue")
lines(boot.sd.mat[,5], lwd = 2, col = "red")

# alpha sd comparisons
plot(true.sd.mat[,6], type = "l", lwd = 2, col = "black", 
     ylim = c(min(true.sd.mat[,6], mean.sd.mat[,6], boot.sd.mat[,6]),
              max(true.sd.mat[,6], mean.sd.mat[,6], boot.sd.mat[,6])),
     main = TeX("SD comparison $\\alpha$", bold = TRUE),
     xlab = "CVs", ylab = "SD")
lines(mean.sd.mat[,6], lwd = 2, col = "blue")
lines(boot.sd.mat[,6], lwd = 2, col = "red")

# Error rates calculations
paras.ests.5cv <- as.matrix(read.table("Parameter estimates 5 cv.txt", sep = "",
                                       header = TRUE))
true.values <- c(0.01, 0.05, 5, 10, 0.01, 0.1)
dn.errs <- (paras.ests.5cv[,1] - true.values[1])/true.values[1]*100
# cv.1.mean.vals cv.2.mean.vals cv.3.mean.vals cv.4.mean.vals cv.5.mean.vals 
#      -46.71214      -53.89473      -60.20330      -71.38590      -75.46927

ga.errs <- (paras.ests.5cv[,2] - true.values[2])/true.values[2]*100
# cv.1.mean.vals cv.2.mean.vals cv.3.mean.vals cv.4.mean.vals cv.5.mean.vals 
#      -33.87357      -35.75273      -38.82977      -41.46673      -44.33536

rn.errs <- (paras.ests.5cv[,3] - true.values[3])/true.values[3]*100
# cv.1.mean.vals cv.2.mean.vals cv.3.mean.vals cv.4.mean.vals cv.5.mean.vals 
#      -30.49725      -32.94774      -36.35924      -39.66229      -42.96245

eta.errs <- (paras.ests.5cv[,4] - true.values[4])/true.values[4]*100
# cv.1.mean.vals cv.2.mean.vals cv.3.mean.vals cv.4.mean.vals cv.5.mean.vals 
#       15.62306       15.70140       15.82919       15.68169       16.17800

dm.errs <- (paras.ests.5cv[,5] - true.values[5])/true.values[5]*100
# cv.1.mean.vals cv.2.mean.vals cv.3.mean.vals cv.4.mean.vals cv.5.mean.vals 
#      -7.338995     -10.151810     -12.425443     -14.849212     -16.835693 

alpha.errs <- (paras.ests.5cv[,6] - true.values[6])/true.values[6]*100
# cv.1.mean.vals cv.2.mean.vals cv.3.mean.vals cv.4.mean.vals cv.5.mean.vals 
#      -1.354083      -1.714066      -2.057398      -2.238979      -2.114405 