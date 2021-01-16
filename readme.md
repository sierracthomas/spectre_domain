## SpECTRE Domain setup

This tutorial will teach you how to set up a process to make a domain in SpECTRE, interpolate SpEC data onto it, then run a perturbed black hole simulation with SpECTRE and output strain data. 

## Setup Instructions

1) Clone this repository on ocean.

2) Clone @moxcode's spectre fork on ocean, or fetch his branches from a different spectre clone. Checkout the `cce_gh_executable_gh_gts` branch and compile the `EvolveGhKerrSchildNumericInitialDataWithCce` executable using `make -j4 EvolveGhKerrSchildNumericInitialDataWithCce`. Use the `support/Environments/ocean_clang.sh` file to load spectre modules. 

3) Compile the `ExportCoordinates3D` executable: in your SpECTRE build directory - the same branch - do `make -j4 ExportCoordinates3D`. 

4) Edit the `setup.sh` script to point to your precloned SpECTRE build directory.

5) Edit the `OceanClang.sh` file in `spectre_constraints` to point to the `BH.yaml` file in there, as well as your precloned SpECTRE directories. 

6) `cd` back into the `spectre_domain` repo, and do `bash setup.sh` to set up the project. 

## High-resolution project instructions

1) If you want to run a perturbed BH with a high resolution (i.e. something like an `InitialRefinement` of 3), use these instructions. To begin, edit `spectre_start_domain/BH.yaml` and `spectre_constraints/KerrSchildPlusCce.yaml`. Make sure these match and point to your own `.h5` files. 

2) Do `bash first_script_high_res.sh`. This will prepare your SpEC run and split the `PointsList.txt` file into pieces that SpEC can run without using too much memory and crashing. This will leave you with a directory called `Interps/` and a bunch of files in the `spec_interp` directory. The `split` function in the script splits the txt file into files called `xaa`, `xab`, and so forth, the number of txt files depending on the resolution. 

3) `cd` into `spec_interp`. Change the `DoMultipleRuns.input` file to point to each of the new txt files (`xaa`, `xab`, ...). In this directory, do `./StartJob`. When this is done, do this: `mv spec_interp/Lev5/Run/InterpolatedData/Interp.dat ../Interps/Interp1.dat`. Remove the `Lev5` directory. Repeat for each new txt file. 

4) When each SpEC run is done, and all of the `Interp<x>.dat` files have been moved and numbered in the `../Interps/` directory, run `bash second_script_high_res.sh`. 

## Low- to normal-resolution project instructions

1) To begin, edit `spectre_start_domain/BH.yaml` and `spectre_constraints/KerrSchildPlusCce.yaml` to match, adding options as desired. Make sure these point to your own `.h5` files. 

2) Use the first script to run the intial SpEC job. Do `bash first_script.sh` and allow that job to run on the compute nodes.

3) When the SpEC job has finished, use the second script to run the SpECTRE job: `bash second_script.sh`. 

4) After the SpECTRE job has finished, use the xdmf converter to convert the `GhBBHVolumeData` files in `spectre_constraints/Run` to a .xmf file. Download both to your local computer and visualize in paraview. 
