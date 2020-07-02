#!/bin/bash

module load ohpc
# Insert SpEC data onto SpECTRE domain
cd spectre_interp
singularity exec /opt/ohpc/pub/containers/spectre_ocean.sif python convert_spectre_spec_coords.py --spectre-points-filename ../spectre_start_domain/VolumeData0.h5 --spec-data-to-insert-filename ../spec_interp/Lev3_AA/Run/ConstraintNorms/InterpolatedData/Interp.dat --output-spectre-points-filename VolumeData0.h5

# Add links to symmetric tensor components
singularity exec /opt/ohpc/pub/containers/spectre_ocean.sif python add_links_to_symmetric_tensor_components.py --input VolumeData0.h5
mv VolumeData0.h5 ID_BBH_VolumeData0.h5

# Submit a SpECTRE job 
cd ../spectre_constraints
sbatch Ocean.sh
