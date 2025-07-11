#!/bin/bash
#SBATCH -e parametric_combine.%j.err
#SBATCH -o parametric_combine.%j.out
#SBATCH --account=nosofs
#SBATCH --qos=batch
#SBATCH --partition=hercules
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=7:00:00
#SBATCH --job-name="combine_nco"
#SBATCH --mem=250GB
#SBATCH --exclusive



# Enable error tracking and timestamps
set -x
echo -n " $( date +%s )," >  job_timestamp.txt

source setup_env.sh

# Print loaded modules for verification
module list

# System settings
ulimit -s unlimited

# Set Intel MPI and OpenMP environment
export OMP_STACKSIZE=512M
export KMP_AFFINITY=scatter
export OMP_NUM_THREADS=1
export I_MPI_EXTRA_FILESYSTEM=ON

# Record hostname and node information
hostname > "CONTROL.TXT"
echo $SLURM_JOB_NODELIST >> "CONTROL.TXT"

# set name of experiment and resolution
  ROOT=/work2/noaa/nos-surge/mjisan/ufs-weather-model-test/HBL_V_DEV5/INIT/boundary_home
  PROJECTS='/work2/noaa/nos-surge/mjisan/ufs-weather-model-test/HBL_V_DEV5/INIT/vortex_gen/'
  EXP=IDEAL
  RES=2.5ms

# set path for mppnccombine utility
  mppnccombine=$ROOT/LIBS/mppnccombine/mppnccombine
  alias mppnccombine=/work/noaa/nosofs/mjisan/ufs-weather-model_V1_August/HBL_V_DEV5/mppnccombine/mppnccombine


# combine output diagnostic spatial files
  cd OUTPUT

  diag_files=`ls *.nc.0000`

  diag_list=$(echo $diag_files | rev | cut -c 6- | rev)

  echo ${diag_list}

# make sure $PROJECTS directory exists
  if [ ! -d "$PROJECTS/${EXP}/${RES}/OUTPUT" ]; then
    mkdir -p $PROJECTS/${EXP}/${RES}/OUTPUT
  fi

# move diagnostic spatial files to $PROJECTS/${EXP}/${RES}/OUTPUT
  mv ${diag_list}.* $PROJECTS/${EXP}/${RES}/OUTPUT

# move diagnostic temporal files to $PROJECTS/${EXP}/${RES}/OUTPUT
  mv diagnostics_temporal.nc $PROJECTS/${EXP}/${RES}/OUTPUT

  cd $PROJECTS/${EXP}/${RES}/OUTPUT

  rm ${diag_list}

# combine diagnostic spatial files 
  /work/noaa/nosofs/mjisan/ufs-weather-model_V1_August/HBL_V_DEV5/mppnccombine/mppnccombine -v -64 ${diag_list} ${diag_list}.*


  module purge
  module load contrib/0.1
  module load noaa-gcc/12.2.0
  echo "Loading NCO module"
  module load nco/5.1.6

# combine diagnostic spatial and temporal files 

  ncks -A ${diag_list} diagnostics_temporal.nc 
  mv diagnostics_temporal.nc ${diag_list}

# remove diagnostic spatial files 
  rm ${diag_list}.* 

exit

