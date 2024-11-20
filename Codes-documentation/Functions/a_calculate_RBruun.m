%% Author: Arnau Garcia Tort
%% Last modification: 05/03/2024
%% Name's project: Bruun Regional & Local Application
%% General formulation: Eq. (1)
%% [ R_Total = R_Bruun + R_Berm + R_Estuary + R_nonSLR ]
%% This function calculates the first component named R_Bruun.
% It enables the calculation of shoreline retreat for any beach using the
% Bruun's rule, requiring only 4 inputs.

%% Inputs: (h*, B, W*, SLR)
    % hast: Depth of closure (Birkemeyer, 1985) [m] 
    % B:    Berm height [m]
    % Wast: Active beach profile width [m] 
    % SLR:  SLR model projections according the IPCC (SSP.245 & SSP.585)[m] 
%%

function [R_Bruun] = a_calculate_RBruun(hast, B, Wast, SLR)

R_Bruun = SLR.*Wast./(B+hast); % Calculating R.Bruun: Equation (2)

end

%% Output:
    % R_Bruun: shoreline retreat component [m]
