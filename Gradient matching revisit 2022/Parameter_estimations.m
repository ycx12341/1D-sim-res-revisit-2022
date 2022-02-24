% Parameter_estimations.m
% Author: Yunchen Xiao

% This MATLAB file generates the plots of parameter estimates at
% different levels of CVs (Coefficient of variations) under different 
% boundary conditions and error models.

%% Environment settings
clc
clear all
close all
 
set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 18)
set(0,'defaultaxeslinewidth',1)
set(0,'defaultpatchlinewidth',1)
set(0,'defaultlinelinewidth',4)
set(0,'defaultTextInterpreter','latex')

%% Read in all the data.
paras_gamma = readtable('Parameter estimates 5 cv gamma.txt');
paras_gamma_icbc = readtable('Parameter estimates 5 cv ICBC gamma.txt');
paras_normal = readtable('Parameter estimates 5 cv normal.txt');
paras_normal_icbc = readtable('Parameter estimates 5 cv ICBC normal.txt');

%% Estimates
% dn estimates
dn_gamma = table2array(paras_gamma(:,2));
dn_gamma_icbc = table2array(paras_gamma_icbc(:,2));
dn_normal = table2array(paras_normal(:,2));
dn_normal_icbc = table2array(paras_normal_icbc(:,2));

% gamma estimates
gamma_gamma = table2array(paras_gamma(:,3));
gamma_gamma_icbc = table2array(paras_gamma_icbc(:,3));
gamma_normal = table2array(paras_normal(:,3));
gamma_normal_icbc = table2array(paras_normal_icbc(:,3));

% rn estimates
rn_gamma = table2array(paras_gamma(:,4));
rn_gamma_icbc = table2array(paras_gamma_icbc(:,4));
rn_normal = table2array(paras_normal(:,4));
rn_normal_icbc = table2array(paras_normal_icbc(:,4));

% eta estimates
eta_gamma = table2array(paras_gamma(:,5));
eta_gamma_icbc = table2array(paras_gamma_icbc(:,5));
eta_normal = table2array(paras_normal(:,5));
eta_normal_icbc = table2array(paras_normal_icbc(:,5));

% dm estimates
dm_gamma = table2array(paras_gamma(:,6));
dm_gamma_icbc = table2array(paras_gamma_icbc(:,6));
dm_normal = table2array(paras_normal(:,6));
dm_normal_icbc = table2array(paras_normal_icbc(:,6));

% alpha estimates
alpha_gamma = table2array(paras_gamma(:,7));
alpha_gamma_icbc = table2array(paras_gamma_icbc(:,7));
alpha_normal = table2array(paras_normal(:,7));
alpha_normal_icbc = table2array(paras_normal_icbc(:,7));

%
x = [0.01 0.025 0.05 0.075 0.1];                               

%% Plot of dn estimates under different CVs, no parameter being fixed.
figure
yyaxis left
plot(x, dn_gamma, 'k-')
title('$\hat{d_n}$')
hold on;
plot(x, dn_gamma_icbc, 'b-')
plot(x, dn_normal, 'r-')
plot(x, dn_normal_icbc, 'g-')
plot(0.01, dn_gamma(1), 'xk', 'markersize', 20)
plot(0.025, dn_gamma(2), 'xk', 'markersize', 20)
plot(0.05, dn_gamma(3), 'xk', 'markersize', 20)
plot(0.075, dn_gamma(4), 'xk', 'markersize', 20)
plot(0.1, dn_gamma(5), 'xk', 'markersize', 20)
plot(0.01, dn_gamma_icbc(1), 'xb', 'markersize', 20)
plot(0.025, dn_gamma_icbc(2), 'xb', 'markersize', 20)
plot(0.05, dn_gamma_icbc(3), 'xb', 'markersize', 20)
plot(0.075, dn_gamma_icbc(4), 'xb', 'markersize', 20)
plot(0.1, dn_gamma_icbc(5), 'xb', 'markersize', 20)
plot(0.01, dn_normal(1), 'xr', 'markersize', 20)
plot(0.025, dn_normal(2), 'xr', 'markersize', 20)
plot(0.05, dn_normal(3), 'xr', 'markersize', 20)
plot(0.075, dn_normal(4), 'xr', 'markersize', 20)
plot(0.1, dn_normal(5), 'xr', 'markersize', 20)
plot(0.01, dn_normal_icbc(1), 'xg', 'markersize', 20)
plot(0.025, dn_normal_icbc(2), 'xg', 'markersize', 20)
plot(0.05, dn_normal_icbc(3), 'xg', 'markersize', 20)
plot(0.075, dn_normal_icbc(4), 'xg', 'markersize', 20)
plot(0.1, dn_normal_icbc(5), 'xg', 'markersize', 20)
yline(0.01,'r--','Linewidth',3.5);
xlim([0 0.11])
xlabel('Measurement error CV')
ylim([-0.0015 0.011])
ylabel('Mean ($\hat{d_n}$)')
yyaxis right
h = plot(x,dn_gamma,'k-');
delete(h)
ylim([-115 10])
ylabel('Percentage error')

%% Plot of gamma estimates under different CVs under different circumstances:
figure
yyaxis left
plot(x, gamma_gamma, 'k-')
title('$\hat{\gamma}$')
hold on;
plot(x, gamma_gamma_icbc, 'b-')
plot(x, gamma_normal, 'r-')
plot(x, gamma_normal_icbc, 'g-')
plot(0.01, gamma_gamma(1), 'xk', 'markersize', 20)
plot(0.025, gamma_gamma(2), 'xk', 'markersize', 20)
plot(0.05, gamma_gamma(3), 'xk', 'markersize', 20)
plot(0.075, gamma_gamma(4), 'xk', 'markersize', 20)
plot(0.1, gamma_gamma(5), 'xk', 'markersize', 20)
plot(0.01, gamma_gamma_icbc(1), 'xb', 'markersize', 20)
plot(0.025, gamma_gamma_icbc(2), 'xb', 'markersize', 20)
plot(0.05, gamma_gamma_icbc(3), 'xb', 'markersize', 20)
plot(0.075, gamma_gamma_icbc(4), 'xb', 'markersize', 20)
plot(0.1, gamma_gamma_icbc(5), 'xb', 'markersize', 20)
plot(0.01, gamma_normal(1), 'xr', 'markersize', 20)
plot(0.025, gamma_normal(2), 'xr', 'markersize', 20)
plot(0.05, gamma_normal(3), 'xr', 'markersize', 20)
plot(0.075, gamma_normal(4), 'xr', 'markersize', 20)
plot(0.1, gamma_normal(5), 'xr', 'markersize', 20)
plot(0.01, gamma_normal_icbc(1), 'xg', 'markersize', 20)
plot(0.025, gamma_normal_icbc(2), 'xg', 'markersize', 20)
plot(0.05, gamma_normal_icbc(3), 'xg', 'markersize', 20)
plot(0.075, gamma_normal_icbc(4), 'xg', 'markersize', 20)
plot(0.1, gamma_normal_icbc(5), 'xg', 'markersize', 20)
yline(0.05,'r--','Linewidth',3.5);
xlim([0 0.11])
xlabel('Measurement error CV')
ylim([0.02 0.055])
ylabel('Mean ($\hat{\gamma}$)')
yyaxis right
h = plot(x,gamma_gamma,'k-');
delete(h)
ylim([-60 10])
ylabel('Percentage error')

%% Plot of rn estimates under different CVs under different circumstances:
figure
yyaxis left
plot(x, rn_gamma, 'k-')
title('$\hat{r_{n}}$')
hold on;
plot(x, rn_gamma_icbc, 'b-')
plot(x, rn_normal, 'r-')
plot(x, rn_normal_icbc, 'g-')
plot(0.01, rn_gamma(1), 'xk', 'markersize', 20)
plot(0.025, rn_gamma(2), 'xk', 'markersize', 20)
plot(0.05, rn_gamma(3), 'xk', 'markersize', 20)
plot(0.075, rn_gamma(4), 'xk', 'markersize', 20)
plot(0.1, rn_gamma(5), 'xk', 'markersize', 20)
plot(0.01, rn_gamma_icbc(1), 'xb', 'markersize', 20)
plot(0.025, rn_gamma_icbc(2), 'xb', 'markersize', 20)
plot(0.05, rn_gamma_icbc(3), 'xb', 'markersize', 20)
plot(0.075, rn_gamma_icbc(4), 'xb', 'markersize', 20)
plot(0.1, rn_gamma_icbc(5), 'xb', 'markersize', 20)
plot(0.01, rn_normal(1), 'xr', 'markersize', 20)
plot(0.025, rn_normal(2), 'xr', 'markersize', 20)
plot(0.05, rn_normal(3), 'xr', 'markersize', 20)
plot(0.075, rn_normal(4), 'xr', 'markersize', 20)
plot(0.1, rn_normal(5), 'xr', 'markersize', 20)
plot(0.01, rn_normal_icbc(1), 'xg', 'markersize', 20)
plot(0.025, rn_normal_icbc(2), 'xg', 'markersize', 20)
plot(0.05, rn_normal_icbc(3), 'xg', 'markersize', 20)
plot(0.075, rn_normal_icbc(4), 'xg', 'markersize', 20)
plot(0.1, rn_normal_icbc(5), 'xg', 'markersize', 20)
yline(5,'r--','Linewidth',3.5);
xlim([0 0.11])
xlabel('Measurement error CV')
ylim([2.8 5.2])
ylabel('Mean ($\hat{r_{n}}$)')
yyaxis right
h = plot(x,gamma_gamma,'k-');
delete(h)
ylim([-44 4])
ylabel('Percentage error')

%% Plot of eta estimations under different CVs under different circumstances:
figure
yyaxis left
plot(x, eta_gamma, 'k-')
title('$\hat{\eta}$')
hold on;
plot(x, eta_gamma_icbc, 'b-')
plot(x, eta_normal, 'r-')
plot(x, eta_normal_icbc, 'g-')
plot(0.01, eta_gamma(1), 'xk', 'markersize', 20)
plot(0.025, eta_gamma(2), 'xk', 'markersize', 20)
plot(0.05, eta_gamma(3), 'xk', 'markersize', 20)
plot(0.075, eta_gamma(4), 'xk', 'markersize', 20)
plot(0.1, eta_gamma(5), 'xk', 'markersize', 20)
plot(0.01, eta_gamma_icbc(1), 'xb', 'markersize', 20)
plot(0.025, eta_gamma_icbc(2), 'xb', 'markersize', 20)
plot(0.05, eta_gamma_icbc(3), 'xb', 'markersize', 20)
plot(0.075, eta_gamma_icbc(4), 'xb', 'markersize', 20)
plot(0.1, eta_gamma_icbc(5), 'xb', 'markersize', 20)
plot(0.01, eta_normal(1), 'xr', 'markersize', 20)
plot(0.025, eta_normal(2), 'xr', 'markersize', 20)
plot(0.05, eta_normal(3), 'xr', 'markersize', 20)
plot(0.075, eta_normal(4), 'xr', 'markersize', 20)
plot(0.1, eta_normal(5), 'xr', 'markersize', 20)
plot(0.01, eta_normal_icbc(1), 'xg', 'markersize', 20)
plot(0.025, eta_normal_icbc(2), 'xg', 'markersize', 20)
plot(0.05, eta_normal_icbc(3), 'xg', 'markersize', 20)
plot(0.075, eta_normal_icbc(4), 'xg', 'markersize', 20)
plot(0.1, eta_normal_icbc(5), 'xg', 'markersize', 20)
yline(10,'r--','Linewidth',3.5);
xlim([0 0.11])
xlabel('Measurement error CV')
ylim([9 12])
ylabel('Mean ($\hat{\eta}$)')
yyaxis right
h = plot(x,gamma_gamma,'k-');
delete(h)
ylim([-10 20])
ylabel('Percentage error')

%% Plot of dm estimations under different CVs in different circumstances:
figure
yyaxis left
plot(x, dm_gamma, 'k-')
title('$\hat{d_{m}}$')
hold on;
plot(x, dm_gamma_icbc, 'b-')
plot(x, dm_normal, 'r-')
plot(x, dm_normal_icbc, 'g-')
plot(0.01, dm_gamma(1), 'xk', 'markersize', 20)
plot(0.025, dm_gamma(2), 'xk', 'markersize', 20)
plot(0.05, dm_gamma(3), 'xk', 'markersize', 20)
plot(0.075, dm_gamma(4), 'xk', 'markersize', 20)
plot(0.1, dm_gamma(5), 'xk', 'markersize', 20)
plot(0.01, dm_gamma_icbc(1), 'xb', 'markersize', 20)
plot(0.025, dm_gamma_icbc(2), 'xb', 'markersize', 20)
plot(0.05, dm_gamma_icbc(3), 'xb', 'markersize', 20)
plot(0.075, dm_gamma_icbc(4), 'xb', 'markersize', 20)
plot(0.1, dm_gamma_icbc(5), 'xb', 'markersize', 20)
plot(0.01, dm_normal(1), 'xr', 'markersize', 20)
plot(0.025, dm_normal(2), 'xr', 'markersize', 20)
plot(0.05, dm_normal(3), 'xr', 'markersize', 20)
plot(0.075, dm_normal(4), 'xr', 'markersize', 20)
plot(0.1, dm_normal(5), 'xr', 'markersize', 20)
plot(0.01, dm_normal_icbc(1), 'xg', 'markersize', 20)
plot(0.025, dm_normal_icbc(2), 'xg', 'markersize', 20)
plot(0.05, dm_normal_icbc(3), 'xg', 'markersize', 20)
plot(0.075, dm_normal_icbc(4), 'xg', 'markersize', 20)
plot(0.1, dm_normal_icbc(5), 'xg', 'markersize', 20)
yline(0.01,'r--','Linewidth',3.5);
xlim([0 0.11])
xlabel('Measurement error CV')
ylim([0.002 0.011])
ylabel('Mean ($\hat{d_{m}}$)')
yyaxis right
h = plot(x,gamma_gamma,'k-');
delete(h)
ylim([-80 10])
ylabel('Percentage error')

%% Plot of alpha estimations under different CVs in different circumstances:
figure
yyaxis left
plot(x, alpha_gamma, 'k-')
title('$\hat{\alpha}$')
hold on;
plot(x, alpha_gamma_icbc, 'b-')
plot(x, alpha_normal, 'r-')
plot(x, alpha_normal_icbc, 'g-')
plot(0.01, alpha_gamma(1), 'xk', 'markersize', 20)
plot(0.025, alpha_gamma(2), 'xk', 'markersize', 20)
plot(0.05, alpha_gamma(3), 'xk', 'markersize', 20)
plot(0.075, alpha_gamma(4), 'xk', 'markersize', 20)
plot(0.1, alpha_gamma(5), 'xk', 'markersize', 20)
plot(0.01, alpha_gamma_icbc(1), 'xb', 'markersize', 20)
plot(0.025, alpha_gamma_icbc(2), 'xb', 'markersize', 20)
plot(0.05, alpha_gamma_icbc(3), 'xb', 'markersize', 20)
plot(0.075, alpha_gamma_icbc(4), 'xb', 'markersize', 20)
plot(0.1, alpha_gamma_icbc(5), 'xb', 'markersize', 20)
plot(0.01, alpha_normal(1), 'xr', 'markersize', 20)
plot(0.025, alpha_normal(2), 'xr', 'markersize', 20)
plot(0.05, alpha_normal(3), 'xr', 'markersize', 20)
plot(0.075, alpha_normal(4), 'xr', 'markersize', 20)
plot(0.1, alpha_normal(5), 'xr', 'markersize', 20)
plot(0.01, alpha_normal_icbc(1), 'xg', 'markersize', 20)
plot(0.025, alpha_normal_icbc(2), 'xg', 'markersize', 20)
plot(0.05, alpha_normal_icbc(3), 'xg', 'markersize', 20)
plot(0.075, alpha_normal_icbc(4), 'xg', 'markersize', 20)
plot(0.1, alpha_normal_icbc(5), 'xg', 'markersize', 20)
yline(0.1,'r--','Linewidth',3.5);
xlim([0 0.11])
xlabel('Measurement error CV')
ylim([0.096 0.101])
ylabel('Mean ($\hat{\alpha}$)')
yyaxis right
h = plot(x,gamma_gamma,'k-');
delete(h)
ylim([-4 1])
ylabel('Percentage error')
