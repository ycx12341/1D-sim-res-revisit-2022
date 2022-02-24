### Gradient matching scheme ########
### Author: Yunchen Xiao & Len Thomas ###########

### Single run on dataset with no measurement error ###

#Environment settings
rm(list = ls())
library(readr)

#Source companion functions
source("PDE_GradientMatching_Functions.r")

### Setup ####

#Define simulation parameters

# Define model parameters
dn <- 0.01
gamma <- 0.05
eta <- 10
dm <- 0.01
alpha <- 0.1
rn <- 5
# This parameter not included in the optimization
beta <- 0
# Make a vector to store the true values
true.values <- c(dn, gamma, rn, eta, dm, alpha)
names(true.values) <- c("dn", "gamma", "rn", "eta", "dm", "alpha")

#No parameters fixed here, so set fixed par to 6 NAs
fixed.par <- rep(NA, 6)
is.estimated <- is.na(fixed.par)
n.estimated <- sum(is.estimated)

#For optimization, use start values from manuscript
start.values <- c(0.01, 0.133, 6.25, 12.5, 0.0166, 0.125)
#Trim to only those for which parameters are being estimated
start.values <- start.values[is.estimated]

# Define 1D dimensionless space points
n.x11 <- 80
max.x11 <- 1
x11 <- seq(0, max.x11, length = n.x11)

# Define time discretization and max time
dt <- 0.001
max.t <- 10

# Set initial conditions
eps <- 0.01
n0 <- rep(0, n.x11)
for (i in 1:n.x11) {
  if (x11[i] <= 0.25) {
    n0[i] <- exp(-x11[i] ^ 2 / eps)
  } else {
    n0[i] <- 0
  }
}
f0 <- 1-0.5*n0
m0 <- 0.5*n0

#Generate reference dataset
ref.data <- generate.reference.data(n.x11, max.x11, dt, max.t,
  dn, gamma, eta, dm, alpha, rn, beta, n0, f0, m0, truncate = FALSE)

### Gradient matching estimation ####

#Obtain gradient approximations
dist <- "normal"
grads <- approximate.gradients(ref.data, x11, max.t, distribution = dist)

write_rds(grads, "Reference gradients GAM imaginary cells BC.rds")
# grads <- read_rds("Reference gradients GAM imaginary cells BC.rds")

#Write gradients predicted by GAM into a .txt file
write.table(grads, "Reference gradients GAM imaginary cells BC.txt")

#Estimate parameter values
res <- optim(start.values, calculate.sse, grads = grads, fixed.par = fixed.par,
             control = list(trace = 1, maxit = 20000, reltol = 1e-10))
par.ests <- res$par
print(par.ests)

# Optimization results using the original BC (full data)
# dn = 0.01008608 gamma = 0.04637674  rn = 4.57673353
# eta = 9.92062979 dm = 0.01070901 alpha = 0.10045449

# Optimization results using the imaginary BC (full data)
# dn = 0.01019719 gamma = 0.04587682 rn = 4.56318074
# eta = 9.91292037 dm = 0.01067712 alpha = 0.10043927

#Calculate percent error
perc.err <- (par.ests - true.values) / true.values * 100
print(perc.err)

# original BC (full data)
#        dn      gamma         rn        eta         dm      alpha 
# 0.8607591 -7.2465292 -8.4653295 -0.7937021  7.0901459  0.4544875

# imaginary BC (full data)
#        dn      gamma         rn        eta         dm      alpha 
# 1.9719243 -8.0463659 -8.7363852 -0.8707963  6.7711982  0.4392664 