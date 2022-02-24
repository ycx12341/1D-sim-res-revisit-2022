## Gradient plots ##

The folder **SimRes_ests_converge_check** contains the results of parameter estimates at 5 different level of measurement errors.

The .R file **True gradients from numerical scheme** generates the true gradients calculated by the finite difference scheme and store them in **True gradients forward difference scheme.txt**. 

The .R file **Gradients averaged over time and data sets** generates the spatial/temporal gradients averaged over time and data sets, then record them in the corresponding .txt files.

The .m file **Gradient_plots** plots the averaged spatial/temporal gradients based on the .txt files generated previously, then save them as the .png files in the folder.

The reference gradients predicted by GAM without measurement errors are stored in **Reference gradients GAM.txt** and **Reference gradients GAM.rds**, which were generated in folder **No measurement errors**, check there for more details of this files.
