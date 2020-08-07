
function [Opt_Par]= fitFun(I,R,De)
%Returns optimizied parmters of the model as follows
% A=beta(connects exposed to susceptible)
% B=alpha(connects  insusceptible to susibtable)
% C=gamma(connects infective to exposed)
% D=sigma(connects quarntined to infective)
% F0=cure rate first coefficient
% F1=cure rate second coefficient
% G0=death rate first coeffcient
% G1=death rate exponential coefficient 
%inputs
%I,R,De (active cases time seris of the country, cumulative recovered
%cases time series , cumulative Death time series
A=0 ; B=0; C=0; D=0;F0=0;F1=0;G0=0; G1=0; %defination of paramters to be optimized
param = [ A , B, C, D, F0, F1, G0, G1];
param = [0.1836    0.0043    0.4469    0.0981    0.0193    0.7083    0.001   0.2902];%intial guesses for model paramters (case of Nigeria)
%[0.2254    0.0277    1.4493    0.0070    0.0834    0.0128    0.0008   -0.0000];%intial guesses for model paramters (case of Oman)
%[0.1271    0.0080    1.9592    0.0192    0.0669    0.0204    0.0015   0.00003];%intial guesses for model paramters (case of saudia arabia)
options = struct('MaxIter',7e4,'MaxFunEvals',6e3,'TolFun',1e-6,'TolX',1e-12, 'Display','iter'); %settings for fminsearch slover
[Opt_Par,fval,exitflag,output] = fminsearch(@fit,param, options) %fitting paramters of the model on the input datasets

output

 
    function Err = fit(param) %the error term to be minimized in fitting process to find the optimized paramters
        h = 1; %Step
 
        alpha = [1,1,1,1,1,1,1]; %order of diffrantiation (for more info R.Garrappa, Numerical Solution of Fractional Differential Equations: A Survey and a Software Tutorial, Mathematics 2018, 6 (2), 16 doi: 10.3390 / math6020016 ( download pdf file )
         
%N=33.7e6; %population of the Country under investigation (Saudi Arabia)
%N=2.78e6;  %%population of the Country under investigation (Qatar)
%N=100e6;   %population of the Country under investigation  (Egypt)
 %N=4.83e6;  %population of the Country under investigation  (Oman)
 N=196e6;    %population of the Country under investigation  (Nigeria)
 f_fun = @(t,y,par) [-(par(1) /N)*y(1)*y(3) - par(2)* y(1); 
                              (par(1) /N)*y(1)*y(3) - par(3) *y(2);  
                               par(3) * y(2)        - par(4)*y(3) ; 
                               par(4) * y(3) - par(5)*(1-exp(-par(6)*t)) * y(4) - par(7)*exp(-par(8)*t) * y(4); 
                               par(5) *(1-exp(-par(6)*t))* y(4); 
                               par(7)* exp(-par(8)*t) * y(4); 
                               par(2) * y(1)] ;    %Equations of the model (modified SEIR) check [1] in readme file                        
                          
                          

       m = length(I); %length of the times series data
       t0 = 1 ; T = m ; %intial and final values of simulation in days
 
%intial values for Egypt
      %yy0=[84998827 -3188299.61490316 ; 3141 146.531795370797 ; 1047 220.088533140553 ; 942.3 20; 102 0.12 ; 24 1.7; 15000126 3187910.81482184];
%intial values for Qatar      
      %yy0 = [2360488;1823.20000000000;2279;2051.10000000000;227;6;417233];
%intial values for Saudi Arabia
     %yy0 =[28641349;2335.20000000000;2919;2627.10000000000;685;47;5055732];
%intial values for Oman and Nigeria (good estimation for any generic country with R0 around 3)          
   yy0=[ 0.85*N-(4.9*I(1)+2*R(1)+2*De(1))  ; 3*I(1); I(1) ; .9*I(1); R(1) ; De(1) ; R(1)+De(1)+.15*N ];
     [t, y] = fde_pi1_ex(alpha,f_fun,t0,T,yy0,h,param); %solving the system of ODEs to optimize the paramters check source [2] in the readme for documentation of this function

      Err   =norm( [y(4,:)-I y(5,:)-R y(6,:)-De ]) ;  % This is for fminsrearch the err to be miniziezed to find the paramters 
    end 
end 