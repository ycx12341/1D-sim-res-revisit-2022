## Gradient Matching revisit 2022 ##
This folder contains all the essential code and results regarding the further analysis on the gradient matching approach presented in Xiao et al. 2021. Due to the rapid deterioration in the accuracy of the previous parameter estimates when the level of perturbation increases, we attempted to improve the situation by making the following adjustments: 

1. Change the error model used to generate perturbed datasets (Gaussian error models instead of gamma) 
2. Change the type of Generalized Additive Models (GAMs) fitted to the datasets (Gaussian models with identity links instead of Gamma models with log links) 
3. Reconstruct the no-flux boundary conditions in the PDE numerical solver by adapting the "imaginary cells" technique.

We conducted four more different attempts using the same gradient matching scheme, but adapting different combinations of the adjustments mentioned above: 

Folder **Gamma errors (imaginary cells BC with truncated data)** contains all the results obtained using gamma GAMs with log link functions fitted to truncated datasets perturbed by gamma errors. No-flux boundary condition constructed using "imaginary cells" technique is used.

Folder **Gamma errors (normal BC with truncated data)** contains all the results obtained using the original method - which was presented in Xiao et al. 2021.

Folder **Normal errors (imaginary cells BC with full data)** contains all the results obtained using Gaussian GAMs with identity link functions fitted to full datasets perturbed by Gaussian errors. No-flux boundary condition constructed using "imaginary cells" technique is used.

Folder **Normal errors (normal BC with full data)** contains all the results obtained using Gaussian GAMs with identity link functions fitted to full datasets perturbed by Gaussian errors. Normal no-flux boundary condition is used.

See the README.md file of each folder for more details.

All simulation results were generated using R 4.0.3 “Bunny-Wunnies Freak Out”.
