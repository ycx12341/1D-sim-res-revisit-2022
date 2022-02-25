#### ABC scheme - Noisy data generation functions ########
### Author: Yunchen Xiao & Len Thomas ###########

generate.reference.data <- function(n.x11, max.x11, dt, max.t,
                                    dn, gamma, ita, dm, alpha, r, beta, n0, f0, m0) {
  #Purpose: Generates a realization from the cancer invasion model
  # Saves output at n.x11 space points evenly distributed between 0 and max.x11
  # and at integer seconds from 0 to max.t.  Model run at time discretization dt
  #Inputs:
  # n.x11 - number of space points to evaluate model and save at
  # max.x11 - max space value (minimum assumed to be 0)
  # dt - time interval for discretization
  # max.t - max time values (minimum assumed to be 0)
  # dn, gamma, ita, dm, alpha, r, beta - model parameters
  # n0, f0, m0 - vectors of initial conditions (of length n.x11)
  #Outputs:
  # n - tumor cell density
  #     matrix containing values of n at (max.t + 1) x n.11 time and space points
  # f - extracelluar matrix (ECM)
  #     matrix containing values of f at (max.t + 1) x n.11 time and space points
  # m - matrix degrading enzyme (ECM)
  #     matrix containing values of m at (max.t + 1) x n.11 time and space points
  #Implementation note:
  # At present restricted to return data from integer time points.  Would be
  # worthwhile to extend to return at arbitrary time points (within the level
  # of precision set by dt)
  
  #Calculate space points and space discretization
  x11 <- seq(0, max.x11, length = n.x11)
  h <- 1/(n.x11 - 1)
  #Calculate time interval to save results at
  t.to.save <- round(1/dt)
  
  # Store the initial values into the result matrix
  res.n <- res.f <- res.m <- matrix(0, max.t + 1, n.x11)
  res.n [1, ] <- n0
  res.f [1, ] <- f0
  res.m [1, ] <- m0
  
  # Run the equations
  p <- 1
  t <- 2
  while(p * dt <= max.t) {
    f[2:(n.x11 - 1)] <- -ita * dt * m[2:(n.x11 - 1)] * f[2:(n.x11 - 1)] + 
      f[2:(n.x11 - 1)]
    
    m[2:(n.x11 - 1)] <- dm * (m[1:(n.x11 - 2)] + m[3:n.x11] - 2 * 
                                m[2:(n.x11 - 1)]) * dt / (h ^ 2) +
      alpha * n[2:(n.x11 - 1)] * dt -  
      beta * m[2:(n.x11 - 1)] * dt + m[2:(n.x11 - 1)]
    
    n[2:(n.x11 - 1)] <- dn * (n[1:(n.x11 - 2)] + n[3:n.x11] - 2 * 
                                n[2:(n.x11 - 1)]) * dt / (h ^ 2) -  
      gamma * (n[3:n.x11] - n[2:(n.x11 - 1)]) * 
      (f[3:n.x11] - f[2:(n.x11 - 1)]) * dt / (h ^ 2) - 
      gamma * n[2:(n.x11 - 1)] * (f[1:(n.x11 - 2)] + f[3:n.x11] - 
                                    2 * f[2:(n.x11 - 1)]) * dt / (h ^ 2) + 
      r * (1 - f[2:(n.x11 - 1)] - n[2:(n.x11 - 1)]) * n[2:(n.x11 - 1)] * dt + 
      n[2:(n.x11 - 1)]
    
    #No flux boundary condition (with imaginary cells)
    #n[1] <- dn * (n[2] - 2 * n[1] + n[2]) * dt / (h ^ 2) - 
    #  gamma * (n[2] - n[1]) * (f[2] - f[1]) * dt / (h ^ 2) - 
    #  gamma * n[1] * (f[2] + f[2] - 2 * f[1]) * dt / (h ^ 2) + 
    #  r * (1 - f[1] - n[1]) * n[1] * dt + n[1]
    
    #n[n.x11] <- dn * (n[n.x11 - 1] - 2 * n[n.x11] + n[n.x11 - 1]) * dt / (h ^ 2) - 
    #  gamma * (n[n.x11 - 1] - n[n.x11]) * (f[n.x11 - 1] - f[n.x11]) * dt / (h ^ 2) - 
    #  gamma * n[n.x11] * (f[n.x11 - 1] + f[n.x11 - 1] - 2 * f[n.x11]) * dt / (h ^ 2) + 
    #  r * (1 - f[n.x11] - n[n.x11]) * n[n.x11] * dt + n[n.x11]
    
    #f[1] <- -ita * dt * m[1] * f[1] + f[1]
    #f[n.x11] <- -ita * dt * m[n.x11] * f[n.x11] + f[n.x11]
    
    
    #m[1] <- dm * (m[2] - 2 * m[1] + m[2]) * dt / (h ^ 2) + 
    #  alpha * n[1] * dt - beta * m[1] * dt + m[1]
    #m[n.x11] <- dm * (m[n.x11 - 1] - 2 * m[n.x11] + m[n.x11 - 1]) * dt / (h ^ 2) +
    #  alpha * n[n.x11] * dt - beta * m[n.x11] * dt + m[n.x11]
    
    n[1] <- n[2]
    n[n.x11] <- n[n.x11 - 1]
    
    f[1] <- f[2]
    f[n.x11] <- f[n.x11 - 1]
    
    m[1] <- m[2]
    m[n.x11] <- m[n.x11 - 1]
    
    # Save the results at integer time steps
    if(p %% t.to.save == 0) {
      res.n[t, ] <- n; res.f[t, ] <- f; res.m[t, ] <- m
      t <- t + 1
    }
    
    p <- p + 1
  }
  return(list (n = res.n, f = res.f, m = res.m))
  
}

perturb.reference.data <- function(ref.data, cv = NULL, sd = NULL, distribution = "gamma") {
  #Purpose: Adds random error to the input dataset
  # Note - for input values less than or equal to zero, no error is added
  #Inputs:
  # ref.data - list with 3 elements n, f and m, each time x space matrices
  # cv - desired coefficient of variation - must be specified for distribution = "gamma"
  #   and either this or sd should be specified for distribution = "normal"
  # sd - desired standard deviation - an alternative to specifying cv for normal distribution
  #   data
  # distribution - if "gamma" adds gamma error; if "normal" adds normal error
  #Outputs:
  # named list of same structure as ref.data, containing perturbed values
  
  #Define function that adds gamma or normal error to a vector of values
  perturb.vec <- function(vec, cv, distribution) {
    ind <- (vec > 0)
    n <- length(vec[ind])
    if(distribution == "gamma") {
      if(is.null(cv)) stop("cv must be specified for gamma distribution\n")
      shape <- (1 / cv)^2
      vec[ind] <- rgamma(n, shape, rate = shape / vec[ind])
    } else {
      if(distribution == "normal") {
        if(is.null(cv)&is.null(sd)) 
          stop("cv or sd must be specified for normal distribution\n")
        if(!is.null(cv)) {
          vec[ind] <- rnorm(n, vec[ind], vec[ind] * cv)
        } else {
          vec[ind] <- rnorm(n, vec[ind], sd)
        }
      } else {
        stop("Specified distribution is not normal or gamma\n")
      }
    }
    return(vec)
  }
  
  #Apply the perturbation
  ref.data$n <- apply(ref.data$n, 2, perturb.vec, cv, distribution)
  ref.data$f <- apply(ref.data$f, 2, perturb.vec, cv, distribution)
  ref.data$m <- apply(ref.data$m, 2, perturb.vec, cv, distribution)
  return(ref.data)
}