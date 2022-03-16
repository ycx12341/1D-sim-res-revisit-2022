rm(list = ls())
library(readr)

n.data <- 10
for (i in 1:n.data) {
  pert.data.res <- read_rds(paste0("./cv5_pert_data", i, ".rds"))
  pert.data <- pert.data.res$pert.data
  n.temp <- pert.data$n[-1,]
  f.temp <- pert.data$f[-1,]
  m.temp <- pert.data$m[-1,]
  
  ncol.data <- length(n.temp[1,])
  
  mean.var.mat <- matrix(0, nrow = ncol.data * 3, ncol = 2) 
  mean.var.mat[1:ncol.data, 1] <- apply(n.temp, 2, mean)
  mean.var.mat[1:ncol.data, 2] <- apply(n.temp, 2 ,var)
  mean.var.mat[(ncol.data + 1):(ncol.data * 2), 1] <- apply(f.temp, 2, mean)
  mean.var.mat[(ncol.data + 1):(ncol.data * 2), 2] <- apply(f.temp, 2, var)
  mean.var.mat[(ncol.data * 2 + 1):(ncol.data * 3), 1] <- apply(m.temp, 2, mean)
  mean.var.mat[(ncol.data * 2 + 1):(ncol.data * 3), 2] <- apply(m.temp, 2, var)
  write_rds(list(ss.mat = mean.var.mat), 
            paste0("./cv5_pert_data", i, "_ss.rds"))
}

