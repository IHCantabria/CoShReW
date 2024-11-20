%% Autor: Arnau Garcia Tort
%% Last modification: 05/03/2024
%% Name's project: Bruun Regional & Local Application
%% General formulation: Eq. (1)
%% [ R_Total = R_Bruun + R_Berm + R_Estuary + R_nonSLR ]
%% This function permits calculation of the second component named R_Estuary.
% The function calculates the additional shoreline retreat due to estuary 
% infilling after sea level rise (SLR from IPCC projections). 
% This only affects those profiles that are nearby the estuary basins.

%% Inputs:(hBeachEstuary,Berm,AreaEstuary,BeachLengthEstuary,AlphaEst,SLR) 
% hBeachEstuary = Average depth of closure of the adjacent beaches to the estuary [m]
% Berm = Berm height [m]
% Ae = Estuary area [m2]
% BeachLenEst = Length of the adjacent beaches to the estuary [m]
% Alpha = Tidal flat growth for the target year [m]
% SLR = Sea Level Rise(values depending on the IPCC scenario considered)[m]
%%

function [R_Estuary] = c_calculate_REstuary(hBeachEstuary,Berm,AreaEst,BeachLenEst,AlphaEst,SLR)

% -- prepare data to calculates all scenarios
nScenarios = size(SLR,2); % number of scenarios considered
nEstuaries = size(AreaEst,2); % number of estuaries that affect the same beach profile
BermScenarios = repmat(Berm,1,nScenarios); % berm heigh of each beach profile

Rest = zeros(size(SLR));

for i=1:nEstuaries
    
    %  prepare data of each estuary that affect the beach profile
    hScenarios = repmat(hBeachEstuary(:,i),1,nScenarios); 
    AreaEstScenarios = repmat(AreaEst(:,i),1,nScenarios);
    BeachLengthScenarios = repmat(BeachLenEst(:,i),1,nScenarios);
    AlphaEstScenarios = repmat(AlphaEst(:,i),1,nScenarios);
    AlphaEstScenarios(AlphaEstScenarios>=SLR) = SLR(AlphaEstScenarios>=SLR); 
    % Condition: if: alfa >= SLR must be limitted for --> alfa = SLR;
  
    %% Calculating R_Estuary: Equation (5)
    % Volume of sand required to restore the Estuary equilibrium shape
    % after SLR (estuary infilling): Equation (6)
    dVE= AreaEstScenarios.*(SLR-AlphaEstScenarios);
    Rest1 = dVE./(BeachLengthScenarios.*(BermScenarios+hScenarios));
    Rest1(isnan(Rest1))=0;
    Rest = Rest + Rest1; % Sum the effect of both estuaries (if its the case)
    R_Estuary = Rest;
end

%% Output:
    % R_Estuary: additional shoreline retreat component [m] 

