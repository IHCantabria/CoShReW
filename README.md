# IH-Bruun ⬆️🌊🏖️🔜
This repository contains a set of codes developed to estimate long-term shoreline retreat due to sea level rise (SLR) in a beach profile. The formulas are based on the traditional Bruun's Rule **(Bruun, 1962)**, which was modified to include both coastal characteristics and processes not accounted for in the original model.

These characteristics and processes are:
  1. The additional erosion due to the demand of sand to fill the berm height along the dry beach after the SLR (Approach from **Rosati et al., 2013)**.
  2. The additional retreat due to the demand of sand to fill the estuarine tidal flats after SLR. This process, known as estuary basin infilling, was first identified by **Ranasinghe et al. (2013)** and further explored in subsequent research by **Toimil et al. (2017)**.
  4. The presence of rocky outcrops or reef planforms. 
  5. The type of backshore (i.e. dune and seawall). 
  6. The effect of shoreline changes non related to the SLR.

These modifications aim to overcome some of the limitations of the original Bruun's Rule and allow the application of the formulas to a broader range of coastal environments. More details on the methodology proposed here can be found in the documents available in this repository.

### License & language
This repo is open-access and is fully developed in **MATLAB**.

## Structure
The information is organized as follows: **Codes-documentation** & **Methodology-documentation** 

### Folders
- **Codes-documentation**: This folder contains the codes, some examples of input data so the user can apply it and the respective documentation. 
    The Codes-documentation is divided into 4 subfolders: 

    - [Functions](https://github.com/ArnauGT98/IH-Bruun/tree/main/Codes-documentation/Functions): Contains the functions required to calculate the shoreline retreat. All these functions are sequentially called from the general script named "General_script.m," which is stored inside the "Script" subfolder.

    - [Input](https://github.com/ArnauGT98/IH-Bruun/tree/main/Codes-documentation/Input): Contains the Initial Matrix file, which is an example of the input for calculation, and a README file for further details. The Input_Matrix.mat file is a 5x30 matrix: 5 hypothetical beach profiles and their 30 calculation parameters.     

      **Each row corresponds to the 5 hypothetical beach profiles:** 
        - (1) Sandy beach profile 
        - (2) Sandy beach profile with chronic erosion rate 
        - (3) Sandy beach profile with rocky outcrop or reef planform 
        - (4) Sandy beach profile located near an estuary 
        - (5) Sandy beach profile with chronic accretion rate and located near an estuary

      These examples cover a broad range of conditions observed in beach profiles worldwide.  

      **Columns correspond to the 30 input parameters required to run the Gerneral_script.m and calculate long term shoreline retreat.**
       <details>
        <summary> Variables summary </summary>

      | Variable              | Description                                                                                                                                                 |     |
      | --------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
      | `ID_general`          | Indicates the identification number of the profile.                                                                                                         |     |
      | `ind_h`               | Indicates the type of seabed. Can be 1 or 2. If its 1: Sandy beach profile, else: Rocky outcrop beach profile.                                              |     |
      | `ind_b`               | Indicates the type of backshore. Can be 1 or 2. If its 1: Dune, else: Seawall-Cliff.                                                                        |     |
      | `indEst`              | Indicates the affection of estuaries. Can be 0 or 1. If its 0: non affected, else: profile affected by an estuary.                                          |     |
      | `B`                   | Berm height.                                                                                                                                                |     |
      | `hast`                | Depth of closure (h*). Birkemeier (1985).                                                                                                                   |     |
      | `wast`                | Active beach profile width (W*). Distance between the shoreline and the depth of closure.                                                                   |     |
      | `hL`                  | Depth of the rocky outcrop or reef platform (hL).                                                                                                           |     |
      | `wL`                  | Distance between the berm and the rocky outcrop or reef platform (wL). Only present in profiles with outcrop or reef formations.                            |     |
      | `L`                   | Dry beach width (L). Distance between the berm and the backshore.                                                                                           |     |
      | `Hd`                  | Height of the first dune ridge at the backshore of the beach (Hd). Only present in dune profiles.                                                           |     |
      | `Ld`                  | Width of the first dune ridge at the backshore of the beach  (Ld). Only present in dune profiles.                                                           |     |
      | `Scr`                 | Shoreline change rate. If its positive: Erosion rate, while if its negative: Accretion rate.                                                                |     |
      | `SLR_2050_245_Q5`     | Sea Level Rise from IPCC SSP2-4.5 for 2050. Percentile. (5%).                                                                                               |     |
      | `SLR_2050_245_Q50`    | Sea Level Rise from IPCC SSP2-4.5 for 2050. Percentile. (50%).                                                                                              |     |
      | `SLR_2050_245_Q95`    | Sea Level Rise from IPCC SSP2-4.5 for 2050. Percentile. (95%).                                                                                              |     |
      | `SLR_2050_585_Q5`     | Sea Level Rise from IPCC SSP5-8.5 for 2050. Percentile. (5%).                                                                                               |     |
      | `SLR_2050_585_Q50`    | Sea Level Rise from IPCC SSP5-8.5 for 2050. Percentile. (50%).                                                                                              |     |
      | `SLR_2050_585_Q95`    | Sea Level Rise from IPCC SSP5-8.5 for 2050. Percentile. (95%).                                                                                              |     |
      | `SLR_2100_245_Q5`     | Sea Level Rise from IPCC SSP2-4.5 for 2100. Percentile. (5%).                                                                                               |     |
      | `SLR_2100_245_Q50`    | Sea Level Rise from IPCC SSP2-4.5 for 2100. Percentile. (50%).                                                                                              |     |
      | `SLR_2100_245_Q95`    | Sea Level Rise from IPCC SSP2-4.5 for 2100. Percentile. (95%).                                                                                              |     |
      | `SLR_2100_585_Q5`     | Sea Level Rise from IPCC SSP5-8.5 for 2100. Percentile. (5%).                                                                                               |     |
      | `SLR_2100_585_Q50`    | Sea Level Rise from IPCC SSP5-8.5 for 2100. Percentile. (50%).                                                                                              |     |
      | `SLR_2100_585_Q95`    | Sea Level Rise from IPCC SSP5-8.5 for 2100. Percentile. (95%).                                                                                              |     |
      | `Ae`                  | Estuary area (Ae).                                                                                                                                          |     |
      | `Le`                  | Length of the adjacent beaches to the estuary.                                                                                                              |     |
      | `hBeachEstuary`       | Average depth of closure of the adjacent beaches to the estuary.                                                                                            |     |
      | `Alpha2050Estuary`    | Tidal flat growth (inside the estuary) for 2050.                                                                                                            |     |
      | `Alpha2100Estuary`    | Tidal flat growth (inside the estuary) for 2100.                                                                                                            |     |

  </details>

    - [Output](https://github.com/ArnauGT98/IH-Bruun/tree/main/Codes-documentation/Output): Contains the file with the results from the calculation: Final_Shoreline_Retreats_2021.mat. This is a 5x12 matrix with the final shoreline retreats calculated for the 5 profiles and 12 SLR scenarios. See the README.txt file for more details. 

    - [Script](https://github.com/ArnauGT98/IH-Bruun/tree/main/Codes-documentation/Script): Contains the general script, which calls all the functions and computes the final shoreline retreats. 
    
  The code and functions include comments with explanations, and further information can be found in the methodology documentation folder.

- **Methodology-documentation**: This folder contains the details on the methodology and tips to apply the codes within this repository.  

    It only contains 1 file: 

    - [1_Methodology](https://github.com/ArnauGT98/IH-Bruun/blob/main/Methodology-documentation/1_Methodology.pdf): This PDF file describes the formulas, their parameters and some tips to estimate each of these parameters in a certain area of interest.
      
 
## Usage
To use the materials of this repo, follow the next steps:

1. Clone the repository to your local machine.
2. Read the codes and methodology documentation. 
3. Change the paths and parameter settings according to your specific coastline characteristics.
4. Run the **General_script.m** with your **Input_Matrix.mat** file.
5. Save and check the output final results to understand the long-term shoreline erosion.

## Contributing
Contributions to the **IH-Bruun** are welcome! If you'd like to contribute, please follow these guidelines:

 - Fork the repository.
 - Create your feature branch (git checkout -b feature/your-feature).
 - Commit your changes (git commit -am 'Add some feature').
 - Push to the branch (git push origin feature/your-feature).
 - Create a new Pull Request.

 And if you liked this repo, don't be shy, put a ⭐STAR⭐ on it!

 ## Acknowledgements
This tool was developed under the national Spanish project _Estudio del efecto Bruun en distintos tramos de la costa andaluza_ _(Bruun Andalucía)_, **(IHCantabria - Junta de Andalucía, 2021)**. We are grateful for the support provided by the European FEDER funding, which enabled the advancements showcased in this project, as well as the ongoing research efforts. Special thanks are extended to _Consejería de Economía, Hacienda y Fondos Europeos (CEHYFE)_ for their support and collaboration throughout this work.

<div align="center">
  <a href="https://github.com/IHCantabria/IH-Bruun.Methodology">
    <img src="Repo-logos/Logos.png" alt="Logo aknowledgements" width="40%">
  </a>
</div>

## References
- **Bruun (1962)**: Sea-Level Rise as a Cause of Shore Erosion. _Journal of the Waterways and Harbors Division, 88(1), 117-130_. [https://doi.org/10.1061/JWHEAU.0000252](https://doi.org/10.1061/JWHEAU.0000252)
- **Rosati et al. (2013)**: The modified Bruun Rule extended for landward transport. _Mar. Geol. 340, 71-81_. [https://doi.org/10.1016/j.margeo.2013.04.018](https://doi.org/10.1016/j.margeo.2013.04.018)
- **Ranasinghe et al. (2013)** :Climate-change impact assessment for inlet-interrupted coastlines. _Nature Clim Change 3, 83–87._ [https://doi.org/10.1038/nclimate1664](https://doi.org/10.1038/nclimate1664)
- **Toimil, et al., (2017)**: Managing coastal erosion under climate change at the regional scale. _Coastal Engineering, 128, 106-122_. [https://doi.org/10.1016/j.coastaleng.2017.08.004](https://doi.org/10.1016/j.coastaleng.2017.08.004)
- **IHCantabria - CAGPyDS, (2021)**: _Informe E1: Caracterización de los perfiles en la costa andaluza_, in: _Estudio del efecto Bruun en distintos tramos de la costa andaluza_ (_Bruun Andalucía_), Santander, Cantabria, Spain.

## Contact
For questions or support, please contact 📧 [arnau.garcia@unican.es](mailto:arnau.garcia@unican.es).

