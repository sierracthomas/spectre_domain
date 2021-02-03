#!/bin/bash

export SPECTRE_BUILD_DIR=${HOME}/jordan_spectre/build
source ${SPECTRE_BUILD_DIR}../support/Environments/ocean_clang.sh
spectre_load_modules

cd spectre_interp

# Add links to symmetric tensor components
python add_links_to_symmetric_tensor_components.py --input VolumeData0.h5
mv VolumeData0.h5 ../spectre_constraints/VolumeData0.h5

# Submit a SpECTRE job 
cd ../spectre_constraints
sbatch Ocean.sh
