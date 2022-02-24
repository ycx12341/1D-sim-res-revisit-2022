## Gradient plots##

The folder **SimRes_ests** contains the results of parameter estimates at 5 different level of measurement errors.

The .R file **Gradients averaged over time and data sets** generates the spatial/temporal gradients averaged over time and data sets, then record them in the corresponding .txt files.

The .m file **Gradient_plots** plots the averaged spatial/temporal gradients based on the .txt files generated previously, then save them as the .png files in the folder.

The reference gradients predicted by GAM without measurement errors and the true gradients calculated by the finite difference scheme are stored in Reference gradients GAM.txt and True gradients forward difference scheme.txt, which were generated in folder **No measurement errors**, check there for more details of these two files.
