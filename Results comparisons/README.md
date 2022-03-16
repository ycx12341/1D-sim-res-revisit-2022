# Results comparisons #
This folder contains the necessary MATLAB and R code used to extract and compare the final ABC and gradient matching parameter estimates under different levels of perturbation (CV). 

File **ABC ests.R** reads in the **CV 1-5 parameter estimates.txt** files which store the final parameter estimates obtained at the end of every run under the corresponding level of perturbations, computes the average values and store them into **Parameter estimates 5 cv abc.txt**. 

File **Parameter_estimations.m** then reads in all the **.txt** files in the folder and construct the comparison plots of the final parameter estimates. The plots are saved as **.png** files in the current folder. 
