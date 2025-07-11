integer, parameter :: ifplane = 0

  integer, parameter :: im = 5400
  integer, parameter :: jm = 5900

  real(KIND=r4), parameter :: lonstart = -82.0
  real(KIND=r4), parameter :: latstart =  21.0
  real(KIND=r4), parameter :: lonend   = -73.9015 ! lonend = lonstart + (im-1)*resol
  real(KIND=r4), parameter :: latend   =  29.8485 ! latend = latstart + (jm-1)*resol


  real(KIND=r4), parameter :: resol  =  0.0015
