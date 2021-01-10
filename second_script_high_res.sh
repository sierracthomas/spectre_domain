#!/bin/bash

# Get rid of legends at the top of each file except first
sed -i '1,3d' Interp2.dat
sed -i '1,3d' Interp3.dat
sed -i '1,3d' Interp4.dat
sed -i '1,3d' Interp5.dat
sed -i '1,3d' Interp6.dat
sed -i '1,3d' Interp7.dat
sed -i '1,3d' Interp8.dat

# Join files together
cat Interp1.dat Interp2.dat Interp3.dat Interp4.dat Interp5.dat Interp6.dat Interp7.dat Interp7.dat > spectre_interp/Interp.dat

module load ohpc
# Insert SpEC data onto SpECTRE domain
cd spectre_interp
singularity exec /opt/ohpc/pub/containers/spectre_ocean.sif python convert_spectre_spec_coords.py --spectre-points-filename ../spectre_start_domain/VolumeData0.h5 --spec-data-to-insert-filename Interp.dat --output-spectre-points-filename VolumeData0.h5

# Add links to symmetric tensor components
singularity exec /opt/ohpc/pub/containers/spectre_ocean.sif python add_links_to_symmetric_tensor_components.py --input VolumeData0.h5
mv VolumeData0.h5 ../spectre_constraints/VolumeData0.h5

# Submit a SpECTRE job 
#cd ../spectre_constraints
#sbatch Ocean.sh
