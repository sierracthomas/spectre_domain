#!/bin/bash

# Make softlink to ExportCoordinates executable - make sure this is compiled in your
# SpECTRE repo

export SPECTRE_BUILD_DIRECTORY=/home/sierra/new_spectre/spectre/build
#export SPEC = path/to/spec

cd spectre_start_domain
ln -s ${SPECTRE_BUILD_DIRECTORY}/bin/ExportCoordinates3D .

# Make a SpEC interpolation directory and copy over SpEC

cd ..
cp -r /home/geoffrey/aps2020/after_aps/import/Domain5b/spec_interp .

# Make old/ directories for the cleanup script

cd ../spectre_interp
mkdir old

cd ../spectre_start_domain
mkdir old

cd ..
