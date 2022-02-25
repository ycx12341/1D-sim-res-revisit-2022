### ABC scheme ########
### Author: Yunchen Xiao & Len Thomas ###########
rm(list = ls())
#Source companion functions
source("PDE_ABC_NoisyDataGeneration_Functions.r")

#Load the package "tictoc" in order to measure the computational time. 
library(tictoc) 
#Load "readr" package for writing results - just check it's loaded
#(it's actually used first inside the parallel routine)
library(readr)
#Load packages for running the simulation in parallel
library(doParallel) 
library(doRNG)


### Setup ####

#Define simulation parameters
#Measurement error CV levels to run (if a scalar then just runs at this one level)
cv <- c(0.01, 0.025, 0.05, 0.075, 0.10)
#Measurement error distribution
dist = "normal"
#Number of simulations at each level of CV
n.sims <- 10
#Whether to save simulation outputs to file or not
# (useful as they are time-consuming to run, and this
# allows further post-processing on results)
save.sims <- TRUE
save.sims.dir <- "Noisy_Data"
#Set random number seed so results are reproducible
# (random number set within each level of CV to make any repeat runs of a 
#  single CV level easier)
rn.seed <- 874513
#Number of parallel threads to run on
n.threads <- detectCores() - 1

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

# Initial values
n <- n0
f0 <- 1-0.5*n0
f <- f0
m0 <- 0.5*n0
m <- m0

#Generate reference dataset
ref.data <- generate.reference.data(n.x11, max.x11, dt, max.t,
                                    dn, gamma, eta, dm, alpha, rn, beta, n0, f0, m0)

### Generate noisy data ####

### Run simulations ####

if(save.sims) {
  if(!dir.exists(save.sims.dir)) dir.create(save.sims.dir)
}

cl <- makeCluster(n.threads/2) 
registerDoParallel(cl)
#Set parallel seed - once = TRUE means it's set each time foreach is called
registerDoRNG(rn.seed, once = TRUE)
#Start the timer
tic()
for(i in 1:length(cv)) {
  #Run the simulation in parallel
  ests <- foreach (sim = 1:n.sims, .combine = rbind) %dopar% {
    #Introduce random error
    pert.data <- perturb.reference.data(ref.data, cv = cv[i], distribution = dist)
    if(save.sims)
      readr::write_rds(list(ref.data = ref.data, pert.data = pert.data), 
                       path = paste0("./", save.sims.dir, 
                                     "/cv", i, "_pert_data", sim, ".rds"))
    
    #Vector to return from the foreach
    c(i, sim)
  }
}
toc()
