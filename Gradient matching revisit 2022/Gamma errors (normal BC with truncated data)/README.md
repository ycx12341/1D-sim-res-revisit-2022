## Gamma errors (normal BC with truncated data) ##
This folder contains all the essential code and results regarding the original gradient matching approach presented in Xiao et al. 2021.  

File **PDE_GradientMatching_Main** and **PDE_GradientMatching_Functions** produce parameter estimates at different CVs. 

File **Convergence check of optimizations** checks the convergence of optimizations performed to obtain the original results, in order to ensure the parameter estimates are obtained after the convergence in **optim** is reached. 

File **Post_process** processes all the simulation results, obtain the final parameter estimates and standard deviations then store them in **Parameter estimates 5 cv.txt**, **Mean SD estimates 5 cv.txt**, **True SD estimates 5 cv.txt** and **Bootstrap SD estimates 5 cv.txt**.

File **PDE_GradientMatching_BootstrapSD** computes the SDs of the parameter estimates using non-parametric bootstrap and store them in folder **SimRes_boots2**.

File **SD analysis** is used to generate the plots of the SDs obtained using different methods (i.e. true SDs, analytical SDs and bootstrap SDs) at different levels of perturbations. These plots are saved as the .png files in this folder.

Folder **Gradient plots** contains all the plots of averaged and explicit spatial/temporal gradients involved in the PDE system.

Folder **Results without measurement errors** contains the reference gradients predicted by GAM in the gradient matching scheme with no measurement errors added to the data and the true gradients calculated by the finite difference scheme. 
 
Folder **SimRes_ests** and **SimRes_ests_converge_check** contains the original results and the updated results with convergence being checked.

The Boostrap SDs stored in **SimRes_boots2** were generated using R 4.0.3 "Bunny-Wunnies Freak Out", while the other simulation results were generated using R 3.5.3 “Great Truth”.
