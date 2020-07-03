## SpECTRE Domain setup

This tutorial will teach you how to setup a process to make a domain 
in spectre, interpolate spec data onto it, and then let spectre run a binary 
black hole job. 


## Setup Instructions

1) Clone this repository to the computer/cluster you will be running the jobs
on. 

2) Edit the setup.sh script to point to your precloned SpEC and SpECTRE directories.

3) Compile the ExportCoordinates3D executable on your SpECTRE branch: in your SpECTRE build directory, enter singularity, then type `make -j4 ExportCoordinates3D`

4) Edit the Ocean.sh file in `spectre_constraints` to point to the BBH.yaml file in there, as well as your precloned SpECTRE directories. 

5) cd back into the spectre_domain repo, and do `bash setup.sh` to set up the project. (Before this step, check to make sure `spec_interp` does not have level data in it - you can do `bash cleanup.sh` to clear this)

## Project instructions

1) To begin, edit `spectre_constraints/BBH.yaml` and `spectre_start_domain/BBH_working.yaml` to match. 

2) Use the first script to run the intial SpEC job. Do `bash first_script.sh` and allow that job to run on the compute nodes.

3) When the SpEC job has finished, use the second script to run the SpECTRE job: `bash second_script.sh` 