#!/bin/bash


# Make softlink to ExportCoordinates executable - make sure this is compiled in your
# SpECTRE repo

export SPECTRE_BUILD_DIRECTORY=${HOME}/gw_spectre/build_singularity

cd spectre_start_domain
ln -s ${SPECTRE_BUILD_DIRECTORY}/bin/EvolveGhKerrSchildNumericInitialDataWithCce

# Make a SpEC interpolation directory and copy over SpEC

cd ..
git clone git@github.com:geoffrey4444/inputfiles.git spec_interp

cd spec_interp
cp SingleBHInterpolateData/* .
ln -s /home/geoffrey/BH/spectre/BHwave/spec_id/Test_ID spec_wave_pulse_id_and_ev
mv ../DoMultipleRuns* .

# Make old/ directories for the cleanup script

cd ../spectre_interp
mkdir old

cd ../spectre_start_domain
mkdir old

cd ..

