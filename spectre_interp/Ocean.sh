#!/bin/bash -
#SBATCH -o spectre.stdout
#SBATCH -e spectre.stderr
#SBATCH --ntasks-per-node 20
#SBATCH -J PythonScript
#SBATCH --nodes 1
#SBATCH -p orca-1
#SBATCH -t 1000:00:00
#SBATCH -D .

module load ohpc

SPECTRE_COMMAND="python convert_spectre_spec_coords.py"
mpirun -np ${SLURM_JOB_NUM_NODES} --map-by ppr:1:node singularity exec \
/opt/ohpc/pub/containers/spectre_ocean.sif \
bash -c "${SPECTRE_COMMAND} --spectre-points-filename ../spectre_start_domain/VolumeData0.h5 --spec-data-to-insert-filename Interp.dat --output-spectre-points-filename VolumeData0.h5"
