In this work, we employed a modified variant of classical SEIR model to predict the dynamics of COVID-19 in Egypt, Qatar and Saudi Arabia.
 We used MATLAB built in nonlinear programming solver “fminsearch” that employs Nelder-Mead algorithm to find the optimized parameters for each country 
then solved the system of the equations numerically to obtain the time evolution of the different mutually exclusive categories of populations suggested by the model 
(susceptible, exposed, Infectious, quarantined, recovered, dead, insusceptible). 

[1]The model
Liangrong Peng, Wuyue Yang, Dongyan Zhang, Changjing Zhuge, and Liu Hong. Epidemic analysis of covid-19 in china by dynamical modeling. arXiv preprint arXiv:2002.06563, 2020. 
 
 FDE Codes ilustratiion 
[2]Matlab rouitne for solving systems or multi-order systems (MOSs) of fractional differential equations (FDEs). MOS are systems of FDEs in which each equation has a different fracrional order. For a detailed description see the paper:
R.Garrappa,  Numerical Solution of Fractional Differential Equations: A Survey and a Software Tutorial, Mathematics 2018, 6(2), 16 
doi:10.3390/math6020016 (download pdf file) http://www.mdpi.com/2227-7390/6/2/16/pdf

The project comes in two files each is self documented
 1.GeneralizedSEIRforCOVID.m
 2.fitFun