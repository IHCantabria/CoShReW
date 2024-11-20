%% Autor: Arnau Garcia Tort
%% Last modification: 05/03/2024
%% Name's project: Bruun Regional & Local Application
%% General formulation: Eq. (1)
%% [ R_Total = R_Bruun + R_Berm + R_Estuary + R_nonSLR ]
%% This function calculates the second component named R_Berm.
% Computes the additional shoreline retreat after the SLR using an adaptation
% of the Bruun Rule proposed by Rosati et al. (2013), with only 5 inputs:

%% Inputs: (B, SLR, L, h*, R_Bruun)
    % B:    Berm height [m]
    % SLR:  SLR model projections according the IPCC(SSP.245 & SSP.585) [m]
    % L:    Dry Beach Width [m]
    % hast: Depth of closure (Birkemeyer, 1985) [m] 
    % R_Bruun: Bruun's rule retreat, calc. using the previous function  [m]
%%

% This is the component relative to the berm filling sand volume: 
% V_Berm : Volume per unit length required to fill the dry beach after 
% profile translation due to SLR --> V_Berm = SLR(L-R_Bruun)--> Equation(4)

% It combines the previous Bruun component with Rosati's adaptation
% component in what we called R.Berm. 

function R_Berm = b_calculate_RBerm(B,SLR,L,hast,R_Bruun)

R_Berm = SLR.*((L-R_Bruun)./(B+hast)); % Calculating R.Berm: Equation (3)

end

%% Output:
    % R_Berm: additional shoreline retreat component [m]
