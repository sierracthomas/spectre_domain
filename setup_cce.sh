#!/bin/bash


# Make softlink to ExportCoordinates executable - make sure this is compiled in your
# SpECTRE repo

export SPECTRE_BUILD_DIRECTORY=${HOME}/gw_spectre/build_singularity

cd spectre_start_domain
ln -s ${SPECTRE_BUILD_DIRECTORY}/bin/EvolveGhKerrSchildNumericInitialDataWithCce

# Make a SpEC interpolation directory and copy over SpEC

cd ..
cp -r /home/geoffrey/spectre_tests/Kerr/Numerical/DampedHarmonic/WavePulse/rebase/spec_interp .

cd spec_interp
rm bin
rm SpEC

# Make old/ directories for the cleanup script

cd ../spectre_interp
mkdir old

cd ../spectre_start_domain
mkdir old

cd ..

#rm -r spec_interp/Lev3_AA