## SpECTRE Domain setup

This tutorial will teach you how to setup a process to make a domain 
in spectre, interpolate spec data onto it, and then let spectre run a binary 
black hole job. 


## Setup Instructions

1) Clone this repository on ocean.

2) Fetch and checkout @geoffrey4444's `bbh_attempt_3` SpECTRE branch and compile in singularity - we do this to use the `EvolveKerrSchildNumericInitialData` executable.

3) Edit the `setup.sh` script to point to your precloned SpECTRE build directory.

4) Compile the `ExportCoordinates3D` executable on your SpECTRE branch: in your SpECTRE build directory, enter the singularity container, then type `make -j4 ExportCoordinates3D`

5) Edit the `Ocean.sh` file in `spectre_constraints` to point to the `BBH.yaml` file in there, as well as your precloned SpECTRE directories. 

6) cd back into the `spectre_domain` repo, and do `bash setup.sh` to set up the project. 

## Project instructions

1) To begin, edit `spectre_constraints/BBH.yaml` and `spectre_start_domain/BBH_working.yaml` to match, adding options as desired.

2) Use the first script to run the intial SpEC job. Do `bash first_script.sh` and allow that job to run on the compute nodes.

3) When the SpEC job has finished, use the second script to run the SpECTRE job: `bash second_script.sh` 

4) After the SpECTRE job has finished, use the xdmf converter to convert the `GhBBHVolumeData` files in `spectre_constraints/Run` to a .xmf file. Download both to your local computer and visualize in paraview. 