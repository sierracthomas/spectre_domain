#!/bin/bash

cd spectre_start_domain/
source /home/sierra/jordan_spectre/support/Environments/ocean_clang.sh
spectre_load_modules

# Make VolumeData0.h5 file based on the input file
/home/sierra/jordan_spectre/build/bin/ExportCoordinates3D --input-file BBH_working.yaml

module purge
module load ohpc

# Output VolumeData0.h5 into a txt file that is readable by SpEC
singularity exec /opt/ohpc/pub/containers/spectre_ocean.sif python convert_spectre_spec_coords.py --spectre-points-filename VolumeData0.h5 --output-spec-points-filename PointsList.txt
cd ../spec_interp

# Break PointsList.txt into pieces with 1572864 lines each to run with SpEC
mv ../spectre_start_domain/PointsList.txt PointsList.log
split PointsList.log -l 1572864

# Run SpEC job to interpolate data onto the domain
#./StartJob.sh

# Make `Interps` directory to store files
mkdir ../Interps/