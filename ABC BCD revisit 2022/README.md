## ABC BCD revisit 2022 ##
This folder contains all the essential code and results regarding the further analysis on the ABC-BCD approach presented in Xiao et al. 2021. We attempted to add perturbations to the main reference datasets in the similar fashion as we did in the gradient matching approach, then investigate how they will affect the accuracy of the ABC parameter estimates: 

1. Same levels of perturbations are used here as the gradient matching attempt (See folder **Gradient matching revisit 2022**). 
2. For each level of perturbations, 10 perturbed datasets are generated and to be evaluated by our ABC-BCD scheme, which results in 50 perturbed datasets in total.  
3. The final parameter estimates regarding each level of perturbation is taken as the average final parameter estimates of its corresponding 10 perturbed datasets.    

The .txt files store the final parameter estimates of each attempt. The corresponding plots of these parameter estimates are generated in **Parameter_estimations.m** and saved as .png files in the current directory. 

Folder **Gamma errors (imaginary cells BC with truncated data)** contains all the results obtained using gamma GAMs with log link functions fitted to truncated datasets perturbed by gamma errors. No-flux boundary condition constructed using "imaginary cells" technique is used to generate the datasets.

Folder **Gamma errors (normal BC with truncated data)** contains all the results obtained using the original method - which was presented in Xiao et al. 2021.

Folder **Normal errors (imaginary cells BC with full data)** contains all the results obtained using Gaussian GAMs with identity link functions fitted to full datasets perturbed by Gaussian errors. No-flux boundary condition constructed using "imaginary cells" technique is used to generate the datasets.

Folder **Normal errors (normal BC with full data)** contains all the results obtained using Gaussian GAMs with identity link functions fitted to full datasets perturbed by Gaussian errors. Normal no-flux boundary condition is used to generate the datasets.

See the README.md file of each folder for more details.

Some simulation results of the original attempt in folder **Gamma errors (normal BC with truncated data)** (also presented in Xiao et al.2021) were generated using R 3.5.3 "Great Truth", while the other simulation results were generated using R 4.0.3 “Bunny-Wunnies Freak Out”.
