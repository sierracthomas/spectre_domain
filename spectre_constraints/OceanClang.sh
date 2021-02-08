#!/bin/bash -
#SBATCH -o spectre.stdout
#SBATCH -e spectre.stderr
#SBATCH --ntasks-per-node 20
#SBATCH -J KerrSchild
#SBATCH --nodes 6
#SBATCH -p orca-1
#SBATCH -t 12:00:00
#SBATCH -D .

# Distributed under the MIT License.
# See LICENSE.txt for details.

# To run a job on Ocean:
# - Set the -J, --nodes, and -t options above, which correspond to job name,
#   number of nodes, and wall time limit in HH:MM:SS, respectively.
# - Set the build directory, run directory, executable name,
#   and input file below.
# - Add a file ${HOME}/.charmrunrc that does the following (replace
#   ${SPECTRE_BUILD_DIR}/../ with the path to your spectre checkout):
#    source ${SPECTRE_BUILD_DIR}/../support/Environments/ocean_clang_lb.sh
#    spectre_load_modules
#
# NOTE: The executable will not be copied from the build directory, so if you
#       update your build directory this file will use the updated executable.
#
# Optionally, if you need more control over how SpECTRE is launched on
# Ocean you can edit the launch command at the end of this file directly.
#
# To submit the script to the queue run:
#   sbatch Ocean.sh

# Replace these paths with the path to your build directory and to the
# directory where you want the output to appear, i.e. the run directory
# E.g., if you cloned spectre in your home directory, set
# SPECTRE_BUILD_DIR to ${HOME}/spectre/build. If you want to run in a
# directory called "Run" in the current directory, set
# SPECTRE_RUN_DIR to ${PWD}/Run
export SPECTRE_BUILD_DIR=${HOME}/jordan_spectre/build
export SPECTRE_RUN_DIR=${PWD}/Run

# Choose the executable and input file to run
# To use an input file in the current directory, set
# SPECTRE_INPUT_FILE to ${PWD}/InputFileName.yaml
export SPECTRE_EXECUTABLE=${SPECTRE_BUILD_DIR}/bin/EvolveGhKerrSchildNumericInitialData
export SPECTRE_INPUT_FILE=${PWD}/KerrSchildPlusCce.yaml

# These commands load the relevant modules and cd into the run directory,
# creating it if it doesn't exist
module load ohpc
source ${SPECTRE_BUILD_DIR}/../support/Environments/ocean_clang.sh
spectre_load_modules
module list

mkdir -p ${SPECTRE_RUN_DIR}
cd ${SPECTRE_RUN_DIR}

# Copy the input file into the run directory, to preserve it
cp ${SPECTRE_INPUT_FILE} ${SPECTRE_RUN_DIR}/

# Set desired permissions for files created with this script
umask 0022

# Set the path to include the build directory's bin directory
export PATH=${SPECTRE_BUILD_DIR}/bin:$PATH

# Flag to stop blas in CCE from parallelizing without charm++
export OPENBLAS_NUM_THREADS=1

# Generate the nodefile
echo "Running on the following nodes:"
echo ${SLURM_NODELIST}
touch nodelist.$SLURM_JOBID
for node in $(echo $SLURM_NODELIST | scontrol show hostnames); do
  echo "host ${node}" >> nodelist.$SLURM_JOBID
done

# The 19 is there because Charm++ uses one thread per node for communication
# Here, -np should take the number of nodes (must be the same as --nodes
# in the #SBATCH options above).
WORKER_THREADS_PER_NODE=$((SLURM_NTASKS_PER_NODE - 1))
WORKER_THREADS=$((SLURM_NPROCS - SLURM_NNODES))
SPECTRE_COMMAND="${SPECTRE_EXECUTABLE} ++np ${SLURM_NNODES} \
++p ${WORKER_THREADS} ++ppn ${WORKER_THREADS_PER_NODE} \
++nodelist nodelist.${SLURM_JOBID}"

charmrun ${SPECTRE_COMMAND} --input-file ${SPECTRE_INPUT_FILE}
