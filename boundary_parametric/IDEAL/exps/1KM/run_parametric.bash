#!/bin/bash
#SBATCH -e boundary_model.%j.err
#SBATCH -o boundary_model.%j.out
#SBATCH --account=nos-surge
#SBATCH --qos=batch
#SBATCH --partition=hercules
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1          
#SBATCH --time=7:00:00
#SBATCH --job-name="model"
#SBATCH --mem=64G                  
##SBATCH --exclusive

# Clear any existing modules
module purge

module load spack-managed-icelake/v1.0
module load intel-oneapi-compilers/2024.2.1
module load intel-oneapi-mpi/2021.13.1
module load hdf5/1.14.3
module load netcdf-c/4.9.2
module load netcdf-fortran/4.6.1

export NETCDF_PATH=$(nc-config --prefix)
export NETCDF_FORTRAN_PATH=$(nf-config --prefix)
export I_MPI_PMI=pmi2
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so
export I_MPI_FABRICS=shm:ofi
export FI_PROVIDER=verbs
export OMP_NUM_THREADS=1           
export KMP_AFFINITY=disabled       
export MKL_NUM_THREADS=1           
export KMP_STACKSIZE=512M          
export OMP_STACKSIZE=512M
ulimit -s unlimited                

# Optimize memory allocation for large arrays
export MALLOC_MMAP_THRESHOLD_=131072
export MALLOC_TRIM_THRESHOLD_=131072
export MALLOC_TOP_PAD_=131072

# Intel runtime optimizations
export KMP_LIBRARY=serial          
export KMP_BLOCKTIME=0

# Request huge pages if available (helps with large array access)
if [ -f /proc/sys/vm/nr_hugepages ]; then
    echo "Huge pages available: $(cat /proc/meminfo | grep -i hugepages)"
fi

# Log system information
echo "=== Job Information ===" > "CONTROL.TXT"
echo "Node: $(hostname)" >> "CONTROL.TXT"
echo "Job ID: $SLURM_JOB_ID" >> "CONTROL.TXT"
echo "Nodelist: $SLURM_JOB_NODELIST" >> "CONTROL.TXT"
echo "CPUs requested: $SLURM_CPUS_PER_TASK" >> "CONTROL.TXT"
echo "Memory requested: $SLURM_MEM_PER_NODE" >> "CONTROL.TXT"
echo "Available memory: $(free -h | head -2)" >> "CONTROL.TXT"
echo "========================" >> "CONTROL.TXT"

# Show CPU information
echo "CPU info:" >> "CONTROL.TXT"
lscpu | grep -E "Model name|CPU MHz|Cache" >> "CONTROL.TXT"

# Check memory limits
echo "Memory limits:" >> "CONTROL.TXT"
ulimit -a | grep -E "stack|virtual|resident" >> "CONTROL.TXT"

echo "Starting execution at: $(date)" >> "CONTROL.TXT"

# Run the executable with timing and memory monitoring
echo "Starting single-threaded model execution..."

# Use /usr/bin/time for detailed memory usage statistics
/usr/bin/time -v srun --mpi=pmi2 --cpus-per-task=1 EXEC/boundary_parametric.exe 2>&1 | tee -a "CONTROL.TXT"

echo "Execution completed at: $(date)" >> "CONTROL.TXT"

# Show final memory usage statistics
echo "=== Final Memory Usage ===" >> "CONTROL.TXT"
echo "Max memory used by job: $(sacct -j $SLURM_JOB_ID --format=MaxRSS --noheader | tail -1)" >> "CONTROL.TXT"

# Keep CONTROL.TXT for performance analysis
echo "Check CONTROL.TXT for detailed performance information"

exit
