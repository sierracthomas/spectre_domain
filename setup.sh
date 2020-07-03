#!/bin/bash

# Make softlink to ExportCoordinates executable - make sure this is compiled in your
# SpECTRE repo

export SPECTRE_BUILD_DIRECTORY = path/to/build/directory
#export SPEC = path/to/spec

cd spectre_start_domain
ln -s ${SPECTRE_BUILD_DIRECTORY}/bin/ExportCoordinates3D .

# Make a SpEC interpolation directory and copy over SpEC

mkdir ../spec_interp && cd ../spec_interp
cp /home/geoffrey/aps2020/after_aps/import/Domain5b/spec_interp/* .

# Make old/ directories for the cleanup script

cd ../spectre_interp
mkdir old

cd ../spectre_start_domain
mkdir old

cd ..
