#!/bin/bash

# cleanup script from previous domain tests. Must have a spectre_start_domain/old/ directory
cd spectre_start_domain
mv PointsList.txt old/
mv VolumeData0.h5 old/
cd ../spec_interp
rm -r Lev5
cd ../spectre_interp
rm BH_ID_VolumeData0.h5
rm /home/sierra/gw_spectre/initial_data_interp/spectre_interp/ID_BBH_VolumeData0.h5
cd ../spectre_constraints
rm -r Run
rm spectre.std*
mkdir ../Old/
mv ../Interps/ ../Old/.
cd ..
rm /home/sierra/gw_spectre/initial_data_interp/spectre_constraints/BH_ID_VolumeData0.h5
rm -r Interps/
