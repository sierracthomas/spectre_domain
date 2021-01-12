## SpECTRE Domain setup

This tutorial will teach you how to setup a process to make a domain 
in spectre, interpolate SpEC data onto it, and then let SpECTRE run a binary 
black hole job. 


## Setup Instructions

1) Clone this repository on ocean.

2) Clone @moxcode's spectre fork on ocean, or fetch his branches from a different spectre clone. Checkout the `cce_gh_executable_gh_gts` branch and compile the `EvolveGhKerrSchildNumericInitialDataWithCce` executable using `make -j4 EvolveGhKerrSchildNumericInitialDataWithCce`. Use the OceanClang.sh file to load spectre modules. 

3) Compile the `ExportCoordinates3D` executable: in your SpECTRE build directory - the same branch - `make -j4 ExportCoordinates3D`

4) Edit the `setup.sh` script to point to your precloned SpECTRE build directory.

5) Edit the `OceanClang.sh` file in `spectre_constraints` to point to the `BH.yaml` file in there, as well as your precloned SpECTRE directories. 

6) cd back into the `spectre_domain` repo, and do `bash setup.sh` to set up the project. 

## Project instructions

1) To begin, edit `spectre_constraints/BBH.yaml` and `spectre_start_domain/BBH_working.yaml` to match, adding options as desired. Make sure these point to your own `.h5` files. 

2) Use the first script to run the intial SpEC job. Do `bash first_script.sh` and allow that job to run on the compute nodes.

3) When the SpEC job has finished, use the second script to run the SpECTRE job: `bash second_script.sh` 

4) After the SpECTRE job has finished, use the xdmf converter to convert the `GhBBHVolumeData` files in `spectre_constraints/Run` to a .xmf file. Download both to your local computer and visualize in paraview. 
