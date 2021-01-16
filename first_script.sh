#!/bin/bash

export SPECTRE_BUILD_DIR=${HOME}/jordan_spectre/build

cd spectre_start_domain/
source ${SPECTRE_BUILD_DIR}/../support/Environments/ocean_clang.sh
spectre_load_modules

# Make VolumeData0.h5 file based on the input file
${SPECTRE_BUILD_DIR}/bin/ExportCoordinates3D --input-file BH.yaml

# Output VolumeData0.h5 into a txt file that is readable by SpEC
python convert_spectre_spec_coords.py --spectre-points-filename VolumeData0.h5 --output-spec-points-filename PointsList.txt
cd ../spec_interp

# Run SpEC job to interpolate data onto the domain
./StartJob.sh
