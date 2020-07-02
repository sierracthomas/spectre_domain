#!/bin/bash

# cleanup script from previous domain tests. Must have a spectre_start_domain/old/ directory
cd spectre_start_domain
mv PointsList.txt old/
mv VolumeData0.h5 old/
cd ../spec_interp
rm -r Lev3_AA
cd ../spectre_interp
rm ID_BBH_VolumeData0.h5
cd ../spectre_constraints
rm -r Run
rm spectre.std*
