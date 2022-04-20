% NRTL script for LLE ocanol and Water
clc, clear all , close all
[P, T, z, feed_rate, alpha, tau12, tau21, R, G12, G21] =  inputs_NRTL;


% gamma_1 = exp( z(2)^2 * (tau_21 * (G_21 / (z(1) + z(2) * G_21)))^2  ...
%              + (tau_12 * G_12) / (z(2) + z(1) * G_12)^2     )
% 
% gamma_2 = exp( z(1)^2 * (tau_12 * (G_12 / (z(2) + z(1) * G_12)))^2  ...
%              + (tau_21 * G_21) / (z(1) + z(2) * G_21)^2     )
% 
% gamma_1_inf = tau_21 * tau_12 * G_12
% 
% gamma_2_inf = tau_12 * tau_21 * G_21



syms x11 x12 x21 x22 gamma11 gamma12 gamma21 gamma22
% x11 is component 1 in phase 1 , x12 is component 1 in phase 2

%mass balances
eqn1 = x11 + x21 == 1;
eqn2 = x12 + x22 == 1;

% eqm relationships

eqn3 = log(x11/x12) == log(gamma12/gamma11) ;
eqn4 = log(x21/x22) == log(gamma22/gamma21) ;

% NRTL Gamma calculations
eqn5 = gamma11 == exp( (x21^2 * (tau21 * (G21/(x11 + x21*G21))^2 ...
    + (tau12*G12)/(x21 + x11*G12)^2)))  ;

eqn6 = gamma21 == exp( (x11^2 * (tau12 * (G12/(x21 + x11*G12))^2 ...
    + (tau21 * G21)/(x11 + x21 * G21)^2))) ;

eqn7 = gamma12 == exp( (x22^2 * (tau21 * (G21/(x12 + x22*G21))^2 ...
    + (tau12*G12)/(x22 + x12*G12)^2)))  ;

eqn8 = gamma22 == exp( (x12^2 * (tau12 * (G12/(x22 + x12*G12))^2 ...
    + (tau21 * G21)/(x12 + x22 * G21)^2))) ;


soln = solve([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8], ...
    [x11, x12, x21, x22, gamma11, gamma12, gamma21, gamma22],'Real', true,IgnoreAnalyticConstraints=true )

%numeric solutions

double(soln.x11)
double(soln.x12)
double(soln.x21)
double(soln.x22)
double(soln.gamma11)
double(soln.gamma12)
double(soln.gamma21)
double(soln.gamma22)