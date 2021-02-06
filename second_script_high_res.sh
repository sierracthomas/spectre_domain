#!/bin/bash

export SPECTRE_BUILD_DIR=${HOME}/jordan_spectre/build
source ${SPECTRE_BUILD_DIR}../support/Environments/ocean_clang.sh
spectre_load_modules

cd Interps/
# Get rid of legends at the top of each file except first
num=2
for i in *.dat; do 
    sed -i '1,3d' "$(printf $num).dat"
    ((num++))
done 

# Join files together
cat 1.dat 2.dat 3.dat 4.dat 5.dat 6.dat 7.dat 8.dat > ../spectre_interp/Interp.dat

# Insert SpEC data onto SpECTRE domain
cd ../spectre_interp
sbatch Ocean.sh
