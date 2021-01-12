#!/bin/bash

export SPECTRE_BUILD_DIR=${HOME}/jordan_spectre/build
source ${SPECTRE_BUILD_DIR}../support/Environments/ocean_clang.sh
spectre_load_modules

# Insert SpEC data onto SpECTRE domain
cd spectre_interp
python convert_spectre_spec_coords.py --spectre-points-filename ../spectre_start_domain/VolumeData0.h5 --spec-data-to-insert-filename ../spec_interp/Lev5/Run/InterpolatedData/Interp.dat --output-spectre-points-filename VolumeData0.h5

# Add links to symmetric tensor components
python add_links_to_symmetric_tensor_components.py --input VolumeData0.h5
mv VolumeData0.h5 ../spectre_constraints/VolumeData0.h5

# Submit a SpECTRE job 
#cd ../spectre_constraints
#sbatch Ocean.sh
