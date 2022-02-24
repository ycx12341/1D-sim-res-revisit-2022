## Gamma errors (normal BC with truncated data) ##
This folder contains all the essential code and results regarding the original gradient matching approach presented in Xiao et al. 2021.  

File **PDE_GradientMatching_Main** and **PDE_GradientMatching_Functions** are used to produce parameter estimates at different CVs. 

File **Convergence check of optimizations** checks the convergence of optimizations performed to obtain the original results, in order to ensure the parameter estimates are obtained after the convergence in **optim** is reached. 

File **Post_process** is used to process all the simulation output and obtain the final results presented in the paper. 

Folder **Gradient plots** contains all the plots of averaged and explicit spatial/temporal gradients involved in the PDE system.

Folder **Results without measurement errors** contains the reference gradients predicted by GAM in the gradient matching scheme with no measurement errors added to the data and the true gradients calculated by the finite difference scheme. 
 
Folder **SimRes_ests** and **SimRes_ests_converge_check** contains the original results and the updated results with convergence being checked.

All simulation results were generated using R 3.5.3 “Great Truth”.
