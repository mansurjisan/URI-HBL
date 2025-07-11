#!/bin/bash -v

#################################################################
# generic compile script for experiments
#################################################################

#################################################################
# set environment
#################################################################

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

# Export compiler variables - USING INTEL MPI WRAPPERS
export FC=mpiifort
export F90=mpiifort
export F77=mpiifort
export MPIF90=mpiifort
export CC=mpiicc
export CXX=mpiicpc

# Get NetCDF paths from config tools
export NETCDF_PATH=$(nc-config --prefix)
export NETCDF_FORTRAN_PATH=$(nf-config --prefix)

# Print configuration for verification
echo "Compiler: $(which $FC)"
echo "NetCDF Fortran compiler: $(nf-config --fc)"
echo "NetCDF C path: $NETCDF_PATH"
echo "NetCDF Fortran path: $NETCDF_FORTRAN_PATH"

# Set make to use parallel jobs
alias make="make -j 2"

list_paths="/work2/noaa/nos-surge/mjisan/ufs-weather-model-test/HBL_V_DEV5/INIT/LIBS/fms/list_paths"
mkmf="/work2/noaa/nos-surge/mjisan/ufs-weather-model-test/HBL_V_DEV5/INIT/LIBS/fms/mkmf"

#################################################################
# set paths
#################################################################

root=$(echo $PWD | cut -d'/' -f-11)
base=/work2/noaa/nos-surge/mjisan/ufs-weather-model-test/HBL_V_DEV5/INIT/boundary_home
src=$base/source
updates=$root/updates
grids=$PWD/GRIDS
cppDefs=
template=$base/templates/intel_default.mk
executable=$PWD/EXEC/boundary_model.exe

#################################################################
# create Makefile
#################################################################

cd $root/objs
rm -f $root/objs/*

$list_paths -o $root/objs/pathnames $src/model $src/shared $grids
echo "Creating Makefile with template: $template"
$mkmf -a $root/objs -m Makefile -t $template -p $executable $updates -c "$cppDefs" $root/objs/pathnames

#################################################################
# call the main Makefile
#################################################################

make -f Makefile
exit
