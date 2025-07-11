#!/bin/bash
#SBATCH -e boundary_model.%j.err
#SBATCH -o boundary_model.%j.out
#SBATCH --account=nos-surge
#SBATCH --qos=batch
#SBATCH --partition=hercules
#SBATCH --nodes=10
#SBATCH --ntasks-per-node=75
#SBATCH --time=7:50:00
#SBATCH --job-name="model"
##SBATCH --exclusive

# Clear any existing modules
module purge

# Load the same modules used during compilation
# Load the Icelake-optimized Spack stack
module load spack-managed-icelake/v1.0

# Load Intel compiler and MPI
module load intel-oneapi-compilers/2024.2.1
module load intel-oneapi-mpi/2021.13.1

# Load HDF5 and NetCDF dependencies
module load hdf5/1.14.3
module load netcdf-c/4.9.2
module load netcdf-fortran/4.6.1

# Set environment variables for runtime
export NETCDF_PATH=$(nc-config --prefix)
export NETCDF_FORTRAN_PATH=$(nf-config --prefix)

# Configure Intel MPI to work correctly with SLURM
export I_MPI_PMI=pmi2
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so
export I_MPI_FABRICS=shm:ofi
export FI_PROVIDER=verbs
export I_MPI_DEBUG=5  # Add debug output to diagnose MPI issues

# Log hostname and node information
hostname > "CONTROL.TXT"
echo $SLURM_JOB_NODELIST >> "CONTROL.TXT"

# Run the executable - make sure this is the correct executable name
# If your executable is actually boundary_parametric.exe, adjust accordingly
time srun --mpi=pmi2 EXEC/boundary_model.exe

# Clean up
rm -f CONTROL.TXT
exit
