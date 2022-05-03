## ABC BCD revisit 2022 ##
This folder contains all the essential code and results regarding the further analysis on the ABC-BCD approach presented in Xiao et al. 2021. We attempted to add perturbations to the main reference datasets in the similar fashion as we did in the gradient matching approach, then investigate how they would affect the accuracy of the ABC parameter estimates: 

1. Same levels of Gaussian perturbations are used here as the gradient matching attempt (See folder **Gradient matching revisit 2022**). 
2. For each level of perturbations, 10 perturbed datasets were generated and evaluated by our ABC-BCD scheme. Hence we evaluated 50 perturbed datasets in total.  
3. The final parameter estimates regarding each level of perturbation was taken as the average final parameter estimates of its corresponding 10 perturbed datasets.    

File **PDE_ABC_NoisyDataGeneration.R** and **PDE_ABC_NoisyDataGeneration_Functions.R** generate the perturbed datasets at each level of perturbations and store them in folder **Noisy_Data**. 

File **mean_var_ref.m** generates the summary statistics (mean & variance of each variable's concentration/density at non-zero integer timepoints in the spatial domain) of the main reference dataset and stores them in **mean_ver_obs.txt**. 

Folder **CV x data simulation** contains all the results regarding the perturbed datasets under the corresponding level of perturbations (cv = x). Check the README.md file of folder **CV 0.01 data simulation** for more details.   

See the README.md file of each folder for more details.

All simulation results were generated using R 4.0.3 “Bunny-Wunnies Freak Out”.
