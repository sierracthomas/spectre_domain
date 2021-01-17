#!/bin/bash

date

export SPECTRE_BUILD_DIR=${HOME}/jordan_spectre/build

cd spectre_start_domain/
source ${SPECTRE_BUILD_DIR}/../support/Environments/ocean_clang.sh
spectre_load_modules

# Make VolumeData0.h5 file based on the input file
${SPECTRE_BUILD_DIR}/bin/ExportCoordinates3D --input-file BH.yaml

# Output VolumeData0.h5 into a txt file that is readable by SpEC
python convert_spectre_spec_coords.py --spectre-points-filename VolumeData0.h5 --output-spec-points-filename PointsList.txt
cd ../spec_interp

# Break PointsList.txt into pieces with 1572864 lines each to run with SpEC
mv ../spectre_start_domain/PointsList.txt PointsList.log
split PointsList.log -l 1572864

# Make `Interps` directory to store files
mkdir ../Interps/

# Check how many x** files there will be, and how many times for loop goes
lines=`wc -l < spec_interp/PointsList.log` 
loops=$((lines/1572864))

#rename each x** file for simplicity
num=0; for i in x*; do mv "$i" "$(printf $num).txt"; ((num++)); done

echo "\$InterpPath = \"${PWD}/spec_interp/0.txt\";" > newtext.txt

cat ${PWD}/spec_interp/DoMultipleRunsHeader.input newtext.txt ${PWD}/spec_interp/DoMultipleRunsRemainder.input > ${PWD}/spec_interp/DoMultipleRuns.input

cd spec_interp/
./StartJob
cd ..

for ((i = 0 ; i < (($loops + 1)) ; i++)); do
    if [ -f spec_interp/Lev5/Run/InterpolatedData/Interp.dat ]; then
	mv spec_interp/Lev5/Run/InterpolatedData/Interp.dat Interps/$(printf (($i - 1))).dat
        echo "Run is done, starting next run..."
	echo "\$InterpPath = \"${PWD}/spec_interp/$(printf $i).txt\";" > newtext.txt
	cat ${PWD}/spec_interp/DoMultipleRunsHeader.input newtext.txt ${PWD}/spec_interp/DoMultipleRunsRemainder.input > ${PWD}/spec_interp/DoMultipleRuns.input
	cd spec_interp/
	./StartJob
	cd ..
    fi
    echo "Run is not yet complete"
    sleep 1s
done

bash second_script_high_res.sh
