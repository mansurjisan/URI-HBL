#!/bin/bash

# Clear any existing modules
module purge

# Load the Icelake-optimized Spack stack
module load spack-managed-icelake/v1.0

# Load Intel compiler and MPI
module load intel-oneapi-compilers/2024.2.1
module load intel-oneapi-mpi/2021.13.1

# Load HDF5 and NetCDF dependencies
module load hdf5/1.14.3
module load netcdf-c/4.9.2
module load netcdf-fortran/4.6.1

# Export compiler variables
export FC=mpiifort
export F90=mpiifort
export F77=mpiifort
export MPIF90=mpiifort

# Get NetCDF paths from config tools
export NETCDF_PATH=$(nc-config --prefix)
export NETCDF_FORTRAN_PATH=$(nf-config --prefix)

# Print configuration for verification
echo "Compiler: $(which mpif90)"
echo "NetCDF Fortran compiler: $(nf-config --fc)"
echo "NetCDF C path: $NETCDF_PATH"
echo "NetCDF Fortran path: $NETCDF_FORTRAN_PATH"
