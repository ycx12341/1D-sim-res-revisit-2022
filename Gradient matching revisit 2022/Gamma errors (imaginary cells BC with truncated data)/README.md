## Gamma errors (imaginary cells BC with truncated data) ##
This folder contains all the essential code and results regarding the gradient matching attempt using Gamma GAMs with log link functions fitted to truncated datasets perturbed by 
gamma errors. No-flux BC boundary condition constructed using the "imaginary cells" technique is used when generating unperturbed dataset with the PDE numerical solver. 

File **PDE_GradientMatching_Main** and **PDE_GradientMatching_Functions** are used to produce parameter estimates at different CVs.

File **Post_process** is used to process all the simulation results and obtain the final parameter estimates.

File **PDE_GradientMatching_BootstrapSD** is used to compute the standard deviations (SDs) of the parameter estimates using non-parametric bootstrap.

File **SD analysis** is used to generate the plots of the SDs obtained using different methods (i.e. true SDs, analytical SDs and bootstrap SDs) at different levels of perturbations.  


Folder **Gradient plots** contains all the plots of averaged spatial/temporal gradients involved in the PDE system.

Folder Results without measurement errors contains the reference gradients predicted by GAM in the gradient matching scheme with no measurement errors added to the data and the true gradients calculated by the finite difference scheme.

Folder Sensitivity tests results contains all the results of the three sensitivity tests mentioned in the manuscript.

Folder SimRes_ests and SimRes_ests_converge_check contains the original results and the updated results with convergence being checked.
