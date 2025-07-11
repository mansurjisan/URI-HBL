integer, parameter :: ifplane = 0

  integer, parameter :: im = 30000
  integer, parameter :: jm = 30000

  real(KIND=r4), parameter :: lonstart = -86.0
  real(KIND=r4), parameter :: latstart =  0.0
  real(KIND=r4), parameter :: lonend   = -73.002 ! lonend = lonstart + (im-1)*resol
  real(KIND=r4), parameter :: latend   =  35.598 ! latend = latstart + (jm-1)*resol


  real(KIND=r4), parameter :: resol  =  0.0015
