#!/bin/bash

# Change this to your input file
export DOMAIN_INPUT=${PWD}/BBH_working.yaml

cd spectre_start_domain/
module load ohpc

# Make VolumeData0.h5 file based on the input file
singularity exec /opt/ohpc/pub/containers/spectre_ocean.sif ./ExportCoordinates3D --input-file ${DOMAIN_INPUT}

# Output VolumeData0.h5 into a txt file that is readable by SpEC
singularity exec /opt/ohpc/pub/containers/spectre_ocean.sif python convert_spectre_spec_coords.py --spectre-points-filename VolumeData0.h5 --output-spec-points-filename PointsList.txt
cd ../spec_interp

# Run SpEC job to interpolate data onto the domain
./StartJob.sh
