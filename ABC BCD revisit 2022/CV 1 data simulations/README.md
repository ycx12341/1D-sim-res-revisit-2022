## CV 1 data simulations ##
This folder contains all the simulation output regarding the 10 noisy datasets generated under the first level of perturbations (cv = 0.01).

File **PDE_ABC_SS_Generation.R** generates the summary statistics for each perturbed dataset and store them into .rds files. These .rds files are already appended to each **Dataset x** folder. 

Folders **Dataset 1-10** contain the detailed simulation output for each dataset. Check the README.md file in folder **Dataset 1** for more details. The structure of the other folders follows in a similar way. 

The final parameter samples for each dataset are stored in the .txt files in this main branch. 

File **Post_process.R** process the final parameter samples of each perturbed datasets and calculates the corresponding final parameter estimates and store them in **CV 1 average parameter estimates.txt**. These 10 sets of final parameter estimates are further averaged to represent the parameter estimates regarding the datasets under current level of perturbations. 
