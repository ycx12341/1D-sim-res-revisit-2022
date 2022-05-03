## Gamma errors (imaginary cells BC with truncated data) ##
This folder contains all the essential code and results regarding the gradient matching attempt using gamma GAMs with log link functions fitted to truncated datasets perturbed by gamma errors. No-flux BC boundary condition constructed using the "imaginary cells" technique was used when generating unperturbed dataset with the PDE numerical solver. 

File **PDE_GradientMatching_Main** and **PDE_GradientMatching_Functions** produce parameter estimates at different CVs, the results are stored in folder **SimRes_ests**.

File **Post_process** processes all the simulation results and obtain the final parameter estimates and standard deviations, then store them in **Parameter estimates 5 cv.txt**, **Mean SD estimates 5 cv.txt**, **True SD estimates 5 cv.txt** and **Bootstrap SD estimates 5 cv.txt**.

File **PDE_GradientMatching_BootstrapSD** computes the SDs of the parameter estimates using non-parametric bootstrap and store them in folder **SimRes_boots2**.

File **SD analysis** generates the plots of the SDs obtained using different methods (i.e. true SDs, analytical SDs and bootstrap SDs) at different levels of perturbations. These plots are saved as the **.png** files in this folder.   

Folder **Gradient plots** contains all the plots of averaged spatial/temporal gradients involved in the PDE system.

Folder **No measurement errors** contains the reference gradients predicted by the corresponding GAM in the gradient matching scheme with no measurement errors added to the data and the true gradients calculated by the finite difference scheme under the current boundary condition setting.
