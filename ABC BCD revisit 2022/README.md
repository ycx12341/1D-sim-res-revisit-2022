## ABC BCD revisit 2022 ##
This folder contains all the essential code and results regarding the further analysis on the ABC-BCD approach presented in Xiao et al. 2021. We attempted to add perturbations to the main reference datasets in the similar fashion as we did in the gradient matching approach, then investigate how they will affect the accuracy of the ABC parameter estimates: 

1. Same levels of perturbations (gaussians) are used here as the gradient matching attempt (See folder **Gradient matching revisit 2022**). 
2. For each level of perturbations, 10 perturbed datasets are generated and to be evaluated by our ABC-BCD scheme, which results in 50 perturbed datasets in total.  
3. The final parameter estimates regarding each level of perturbation is taken as the average final parameter estimates of its corresponding 10 perturbed datasets.    

File **PDE_ABC_NoisyDataGeneration.R** and **PDE_ABC_NoisyDataGeneration_Functions.R** generates the perturbed datasets at each level of perturbations and store them in folder **Noisy_Data**. 

File **mean_var_ref.m** generates the summary statistics (mean & variance of each variable's concentration/density at non-zero integer timepoints in the domain) of the main reference dataset and store them in **mean_ver_obs.txt**. 

Folder **CV x data simulation** contains all the results regarding the perturbed datasets under the corresponding level of perturbations (cv = x).   

See the README.md file of each folder for more details.

All simulation results were generated using R 4.0.3 “Bunny-Wunnies Freak Out”.

**Work in progress...**
