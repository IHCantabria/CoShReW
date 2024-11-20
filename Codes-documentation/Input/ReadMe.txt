
This ReadMe explains the structure and contents of the Input_Matrix file.

It contains 5 hypothetical beach profiles: 

1. Sandy beach profile: correspond to a sandy beach profile with a seawall on the backshore. 
(Non affected by rocky outcrops or reefs, dunes, nearby estuaries, and with an eosion rates = 0). 
        
2. Sandy beach profile with chronic erosion rate: correspond to a sandy beach profile with a chronic erosion rate = 0.17 m/yr. 
(Non affected by rocky outcrop formations, dunes or nearby estuaries).
        
3. Sandy beach profile with rocky outcrop or reef planform: corresponds to a rocky outcrop/reef profile with a seawall/cliff on the backshore. 
(Non affected by dunes or nearby estuaries, and with an erosion rate = 0).

4. Sandy beach profile located nearby estuary: correspond to a sandy beach profile with a seawall/cliff on the backshore and affected simultaneously by 2 estuaries. 
(Non affected by dunes, and with an erosion rate = 0).

5. Sandy beach profile with chronic accretion rate and located nearby estuary: corresponds to a sandy beach profile with dunes on the backshore, that it's affected simultaneously by 2 estuaries and it is also affected by a negative erosion rate, which means accretion (the beach goes wider). 

Please note that the Input_Matrix.mat file does not allow empty values. All required parameters must have their own value, NaN, or zero if a parameter is not affected.