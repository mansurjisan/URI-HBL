# template for the Intel fortran compiler - OPTIMIZED VERSION

##############################################
# Need to use at least GNU Make version 3.81 #
##############################################
need := 3.81
ok := $(filter $(need),$(firstword $(sort $(MAKE_VERSION) $(need))))
ifneq ($(need),$(ok))
$(error Need at least make version $(need).  Load module gmake/3.81)
endif

############
# commands #
############

# Using Intel MPI wrappers for Intel compilers
FC = mpiifort -mcmodel=medium
LD = mpiifort -mcmodel=medium

###########
# options #
###########

# OPTIMIZED FLAGS FOR SINGLE-THREADED PERFORMANCE
# Disable deprecation warning
SILENCE_WARNINGS = -diag-disable=10448

# Base optimization flags (removed conflicting xHost/march)
BASE_OPT = -O3 -march=native -ipo -no-prec-div -fp-model fast=2

# Vectorization flags (removed unsupported vec-report=6)
VECTOR_OPT = -qopt-report=5 -qopt-report-phase=vec,loop

# Memory and cache optimization
MEMORY_OPT = -align array64byte -qopt-prefetch=4 -qopt-streaming-stores=always

# Advanced optimization flags for single-threaded performance
ADVANCED_OPT = -unroll-aggressive -finline-functions -ffast-math

# Debugging flags (comment out for production runs)
DEBUG_FLAGS = -g -traceback

# NetCDF paths are now taken from environment variables
FFLAGS = $(SILENCE_WARNINGS) $(BASE_OPT) $(VECTOR_OPT) $(MEMORY_OPT) $(ADVANCED_OPT) $(DEBUG_FLAGS) -I$(NETCDF_PATH)/include -I$(NETCDF_FORTRAN_PATH)/include

FPPFLAGS =
LDFLAGS = -lm -L$(NETCDF_PATH)/lib -L$(NETCDF_FORTRAN_PATH)/lib -lnetcdff -lnetcdf
OTHERFLAGS =

# Alternative configurations (comment/uncomment as needed)
# For production runs (remove debug info):
# FFLAGS = $(SILENCE_WARNINGS) $(BASE_OPT) $(VECTOR_OPT) $(MEMORY_OPT) $(ADVANCED_OPT) -I$(NETCDF_PATH)/include -I$(NETCDF_FORTRAN_PATH)/include

# For maximum performance (potentially less stable):
# FFLAGS = $(SILENCE_WARNINGS) -Ofast -march=native -ipo -unroll-aggressive -finline-functions -I$(NETCDF_PATH)/include -I$(NETCDF_FORTRAN_PATH)/include

# For debugging (slower but safer):
# FFLAGS = $(SILENCE_WARNINGS) -O0 -g -traceback -check bounds -check uninit -warn all -I$(NETCDF_PATH)/include -I$(NETCDF_FORTRAN_PATH)/include

# Using newer ifx compiler instead of deprecated ifort (if available):
# FC = mpiifort -mcmodel=medium
# LD = mpiifort -mcmodel=medium

#---------------------------------------------------------------------------
# you should never need to change any lines below.

# see the MIPSPro F90 manual for more details on some of the file extensions
# discussed here.
# this makefile template recognizes fortran sourcefiles with extensions
# .f, .f90, .F, .F90. Given a sourcefile <file>.<ext>, where <ext> is one of
# the above, this provides a number of default actions:

# make <file>.opt       create an optimization report
# make <file>.o         create an object file
# make <file>.s         create an assembly listing
# make <file>.x         create an executable file, assuming standalone
#                       source
# make <file>.i         create a preprocessed file (for .F)
# make <file>.i90       create a preprocessed file (for .F90)

# The macro TMPFILES is provided to slate files like the above for removal.

RM = rm -f
SHELL = /bin/csh -f
TMPFILES = .*.m *.B *.L *.i *.i90 *.l *.s *.mod *.opt *.optrpt

.SUFFIXES: .F .F90 .H .L .T .f .f90 .h .i .i90 .l .o .s .opt .x

.f.L:
	$(FC) $(FFLAGS) -c -listing $*.f
.f.opt:
	$(FC) $(FFLAGS) -c -opt_report_level max -opt_report_phase all -opt_report_file $*.opt $*.f
.f.l:
	$(FC) $(FFLAGS) -c $(LIST) $*.f
.f.T:
	$(FC) $(FFLAGS) -c -cif $*.f
.f.o:
	$(FC) $(FFLAGS) -c $*.f
.f.s:
	$(FC) $(FFLAGS) -S $*.f
.f.x:
	$(FC) $(FFLAGS) -o $*.x $*.f *.o $(LDFLAGS)
.f90.L:
	$(FC) $(FFLAGS) -c -listing $*.f90
.f90.opt:
	$(FC) $(FFLAGS) -c -opt_report_level max -opt_report_phase all -opt_report_file $*.opt $*.f90
.f90.l:
	$(FC) $(FFLAGS) -c $(LIST) $*.f90
.f90.T:
	$(FC) $(FFLAGS) -c -cif $*.f90
.f90.o:
	$(FC) $(FFLAGS) -c $*.f90
.f90.s:
	$(FC) $(FFLAGS) -c -S $*.f90
.f90.x:
	$(FC) $(FFLAGS) -o $*.x $*.f90 *.o $(LDFLAGS)
.F.L:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -listing $*.F
.F.opt:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -opt_report_level max -opt_report_phase all -opt_report_file $*.opt $*.F
.F.l:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c $(LIST) $*.F
.F.T:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -cif $*.F
.F.f:
	$(FC) $(CPPDEFS) $(FPPFLAGS) -EP $*.F > $*.f
.F.i:
	$(FC) $(CPPDEFS) $(FPPFLAGS) -P $*.F
.F.o:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c $*.F
.F.s:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -S $*.F
.F.x:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -o $*.x $*.F *.o $(LDFLAGS)
.F90.L:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -listing $*.F90
.F90.opt:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -opt_report_level max -opt_report_phase all -opt_report_file $*.opt $*.F90
.F90.l:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c $(LIST) $*.F90
.F90.T:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -cif $*.F90
.F90.f90:
	$(FC) $(CPPDEFS) $(FPPFLAGS) -EP $*.F90 > $*.f90
.F90.i90:
	$(FC) $(CPPDEFS) $(FPPFLAGS) -P $*.F90
.F90.o:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c $*.F90
.F90.s:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -c -S $*.F90
.F90.x:
	$(FC) $(CPPDEFS) $(FPPFLAGS) $(FFLAGS) -o $*.x $*.F90 *.o $(LDFLAGS)
