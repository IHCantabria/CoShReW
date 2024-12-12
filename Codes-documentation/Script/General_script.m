%% Autor: Arnau Garcia Tort
%% Last modification: 05/03/2024
%% Name's project: Long-Term Shoreline Retreat Calculator
%% 
%% --------------------  General script -----------------------------------
% This script calculates the long term coastal shoreline retreat of a beach
% due to sea level rise (SLR), represented as the cross-shore erosion 
% measured in beach profiles [m].

% By this simple general formulation:
% [R_Total = R_Bruun + R_Berm + R_Estuary + R_nonSLR]

% This script:
%% 1. Reads the initial matrix as input (Initial_Matrix: 5 beach profiles)
%% 2. Preprocess: Defines index for all corrections needed
%% 3. Calculate each component separately (using the predefined functions)
%% 4. Compute all together: General formulation --> Eq (1)
%% 5. Implements all the corrections and limitations giving as only 1 Output
%% 6. Save Output: R.Total_corrected (Matrix of 5 rows x 12 columns)

close all; clear *; clc; 

%% 1) Define Paths: This must be adapted to your current work directory
MainPath = '...Your Main Path...\Codes-documentation\';
SavePath = '...Your Save Path ...\Codes-documentation\Output\';
addpath([MainPath '\Functions'])

% Load the Input data --> (stored on the input folder)
load('...Your Input Path...\Codes-documentation\Input\Initial_Matrix.mat')

%% 2) Preprocessing -- Define all index needed depending on profile type --
indh    = find(data.ind_h==2);      % profiles with rocky outcrops or reefs

% You can comment or uncomment 
inddune = find(data.ind_b==1);      % profiles with dunes on the backshore
indwall = find(data.ind_b==2);      % profiles with walls-cliffs- etc...
indout = find(data.Outliers == 1);
% This is just to know which data corresponds to each type of profile, for
% example, in this initial matrix you have 5 hypothetical beach profiles: 

% Profile(1) = Sandy beach profile with a seawall on the backshore. 
% (Non affected by rocky outcrops or reefs, dunes, nearby estuaries, and with an eosion rates = 0).
% Profile(2) = Sandy beach profile with a chronic erosion rate = 0.17 m/yr. 
% (Non affected by rocky outcrop formations, dunes or nearby estuaries).
% Profile(3) = Rocky outcrop/reef profile with a seawall/cliff on the backshore. 
% (Non affected by dunes or nearby estuaries, and with an erosion rate = 0).
% Profile(4) =  Sandy beach profile with a seawall/cliff on the backshore and affected simultaneously by 2 estuaries. 
% (Non affected by dunes, and with an erosion rate = 0).
% Profile(5) = Sandy beach profile with dunes on the backshore, that it's affected simultaneously by 2 estuaries 
% and it is also affected by a negative erosion rate, which means accretion (the beach goes wider). 

%% --- Define all the calculation parameters required for the functiond ---
% SLR
    SLR = table2array(data(:,14:25)); SLR(SLR<0)=0;
% Berm height
    B = data.B;  B = repmat(B,1,size(SLR,2));
% Dry beach width
    L = data.L;  L = repmat(L,1,size(SLR,2));
% Height and width of the first dune ridge
    Hd = data.Hd; Hd = repmat(Hd,1,size(SLR,2));
    Ld = data.Ld; Ld = repmat(Ld,1,size(SLR,2));
% Active beach profile width (W*) 
    Wast = data.wast; 
    Wast(indh)=data.wL(indh);
    Wast = repmat(Wast,1,size(SLR,2));
% Depth of closure (h*) (Birkemeier, 1985)
    hast = -data.hast;
    hast(indh)=-data.hL(indh); 
    hast = repmat(hast,1,size(SLR,2));
% BackShoreType indicates what kind of profile backshore we have
    BackShoreType = data.ind_b -1;
% Shoreline change rate (+ is Erosion rate, - is Accretion rate)
    Scr = data.Scr;
% Target years horizons [2050-2100]: Complete time of the analysis
    yy_horiz1 = 2050; yy_horiz2 = 2100; 
    yy1 = repmat(yy_horiz1,size(data,1),size(SLR,2)/2);
    yy2 = repmat(yy_horiz2,size(data,1),size(SLR,2)/2);
    yy_target = horzcat(yy1,yy2);
    % We asume that 2022 is our actual year
    yy_actual = repmat(2022,size(data,1),size(SLR,2));
% --- Parameters for R_Estuary ---
    YearsToHorizon2050 = 2050-2022;
    YearsToHorizon2100 = 2100-2022;
    indEst = data.indEst;
    hBeachEstuary = -data.hBeachEstuary;
    Berm = data.B;
    Ae = data.AreaEstuary; 
    BeachLengthEstuary = data.L_E;
    alpha2050 = data.alpha2050Estuary;
    alpha2100 = data.alpha2100Estuary;
    SLR2050 = [data.SLR_2050_SSP245_Q5 data.SLR_2050_SSP245_Q50 data.SLR_2050_SSP245_Q95 data.SLR_2050_SSP585_Q5 data.SLR_2050_SSP585_Q50 data.SLR_2050_SSP585_Q95];
    SLR2100 = [data.SLR_2100_SSP245_Q5 data.SLR_2100_SSP245_Q50 data.SLR_2100_SSP245_Q95 data.SLR_2100_SSP585_Q5 data.SLR_2100_SSP585_Q50 data.SLR_2100_SSP585_Q95];
    % clear unnecessary variables
    clear indh indwall inddune indEst yy1 yy2 yy_horiz1 yy_horiz2 data

%% 3) Start calculating each component separately
%% 3.1) Calculates R_Bruun 
R_Bruun = a_calculate_RBruun(hast, B, Wast, SLR); 
%% 3.2) Calculates R_Berm 
R_Berm = b_calculate_RBerm(B, SLR, L, hast, R_Bruun);
%% 3.3) Calculates R_Estuary
% target year 2050 
R_Est2050 = c_calculate_REstuary(hBeachEstuary,  Berm, Ae,  BeachLengthEstuary,  alpha2050,  SLR2050);
% target year 2100 
R_Est2100 = c_calculate_REstuary(hBeachEstuary,  Berm, Ae,  BeachLengthEstuary,  alpha2100,  SLR2100);
% Concatenate in same variable R_Estuary all together (2050 y 2100)
R_Estuario = horzcat(R_Est2050,R_Est2100);
%% 3.4) Calculates_RnonSLR 
RnonSLR = d_calculate_RnonSLR(Scr,yy_target,yy_actual);

%% 4) Compute all together--> R_Total (linear sum of previous 4 components)
R_Total = R_Bruun + R_Berm + R_Estuario + RnonSLR; 

%% 5) Correcting R.Total 
R_Total_corrected = e_Rtotal_corection(R_Total,hast,B,L,Hd,Ld,BackShoreType);

%% 6) Saving Output: R_Total_corrected
cd(SavePath)
%save('Final_Shoreline_Retreats',"R_Total_corrected"); 