%% Autor: Arnau Garcia Tort
%% Last modification: 05/03/2024
%% Name's project: Bruun Regional & Local Application
%% General formulation: Eq.(1)
%% [ R_Total = R_Bruun + R_Berm + R_Estuary + R_nonSLR ]
%% This function permits to correct R_Total to the final [R_Total_corrected]
% This function allows to correct the final shrl.retreat depending on the
% site-specific caracteristics of the beach profile

%% Inputs: (R_Total, h*, B, W*, SLR, L, Hd, Ld, idx_BackShoreType)
    % R_Total: Total shrl.retreat without corrections and limitations [m]
    % hast:    Depth of closure (Birkemeyer, 1985) [m]
    % B:       Berm height [m]
    % Wast:    Active beach profile width [m]
    % SLR:     Sea Level Rise according the IPCC(SSP.245 y 585) [m]
    % L:       Dry beach width [m]
    % Hd:      Height of the first dune ridge [m]
    % Ld:      Width  of the first dune ridge [m]
    % BackShoreType: Index that indicates the kind of backshore we have. 
%%

function [R_Total] = e_Rtotal_corection(R_Total, hast, B, L, Hd, Ld, BackShoreType)

%% Correction #1 - Corrects Seawall-Cliff- ended profiles 
%idx1 = Profiles with a Sea-Wall where final retreat has already eroded all
%the dry beach sediment available 
idx1 = BackShoreType & R_Total > L; 

% Aplying the seawall-cliffs limitation/restriction: Equation (8)
R_Total(idx1) = L(idx1); % If the condition is true, the final retreat must 
% be limitted to a maximum of the Dry Beach With (L).
    
%% Correction #2- Corrects Dune profiles
%idx2 = Dune profiles where final retreat has already reached the dune foot
idx2 = ~BackShoreType & R_Total > L; 

% Aplying the Dune's retreat adaptation: Equation (9)
R_Total(idx2) = R_Total(idx2) - (((R_Total(idx2)-L(idx2)).*Hd(idx2))./ (B(idx2)+hast(idx2)));

%This formulation is only valid if R_Bruun erodes the hole dry beach
% R_Total(idx2) = (SLR(idx2).*Wast(idx2) - (R_Total(idx2)-L(idx2)).*Hd(idx2) ) ./ (B(idx2)+hast(idx2)); 

%idx3 = Dune profiles where final retreat erodes all the 1rst dune ridge sand
idx3 = ~BackShoreType & R_Total > L+Ld; % Equation (10) 
R_Total(idx3) = L(idx3)+Ld(idx3);% if this condition is true, final retreat 
% must be limitted as maximum as the sum of Dry beach width + Width  of the 
% first dune ridge. We assume that beach can't erode furthermore than that.  

end

%% Output:
    % R_Total_corrected: final shoreline retreat [m]
