%% Autor: Arnau Garcia Tort
%% Last modification: 05/03/2024
%% Name's project: Bruun Regional & Local Application
%% General formulation: Eq. (1)
%% [ R_Total = R_Bruun + R_Berm + R_Estuary + R_nonSLR ]
%% This function calculates the second component named R_nonSLR.
% The function calculates the additional shoreline retreat due to factors 
% non related to SLR. 
% Essentially it's caused by the effect of the chronic shoreline change (Scr)
% rates; in this case if its positive means erosion, while if its negative 
% is considered as accretion rate.
% The function requires only 3 inputs: 

%% Inputs: (Scr,yy_target,yy_actual)
% Scr: Shoreline change rate (Erosion [+] accretion [-])[m/yr].
% yy_target: target year for which the shrl.retreat is going to be evaluated.
% In this case the target years are 2050 or 2100 [yrs].
% yy_actual: actual year. In this case we asume 2022 as the current year
%%

function [R_nonSLR] = d_calculate_RnonSLR(Scr,yy_target,yy_actual)

R_nonSLR = Scr.*(yy_target-yy_actual); % Calculating **Equation (7)**

end

%% Output:
    % R_nonSLR: additional shoreline retreat component [m]

