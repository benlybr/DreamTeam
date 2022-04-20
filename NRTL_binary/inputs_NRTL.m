%inputs function
% gets input values for 
% Temperature [K]
% octanol mole frac
% molar feed rate [mol/min]

%Assigns values for
%Pressure 1 bar
% alpha octanol & water
% tau for the given temp
function [P, T, z, feed_rate, alpha, tau12, tau21, R, G12, G21] = inputs_NRTL;


prompt_T = ['\n What is the liquid feed temperature in Kelvin? \n' ...
    '300K to 350K >: '];

prompt_frac_x1 = '\n What is the mole fraction of component one in the feed? >: '; 

prompt_feed_rate = '\n What is the feed rate in moles per minute? >: ';

%NRTL specific parameters for ocanol and Water

%Gas constant

R =1.98720425864083; %cal/mok K

%alpha
alpha = .2 ;

%Temp and pressure
P = 1; % bar
T = input(prompt_T);

%Feed rate
feed_rate = input(prompt_feed_rate);

%mole fractions of feed
z1 = input(prompt_frac_x1);
z2 = 1-z1;

z = [z1 z2];

%tau calculations
%A_12 = -125 * 4.184; % (cal/mol)*(J/Cal) = J/mol
A_12 = -125 ; % (cal/mol)

%A_21 = 4181 * 4.184; % (cal/mol)*(J/Cal) = J/mol
A_21 = 4181 ; % (cal/mol)

tau12 = A_12/(R*T);

tau21 = A_21/(R*T);

G12 = exp(- alpha * tau12);

G21 = exp(- alpha * tau21);



end