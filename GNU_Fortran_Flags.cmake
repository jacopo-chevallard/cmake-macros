MESSAGE ( STATUS "Adding default compiler flags for GNU compiler")
#set ( CMAKE_Fortran_FLAGS "-DLAPACK -g -O0 -cpp -fcheck=all -fbacktrace -fbounds-check -ffree-line-length-none -fPIC -fallow-invalid-boz ${CMAKE_Fortran_FLAGS}" )
set ( CMAKE_Fortran_FLAGS "-DLAPACK -g -O3 -cpp -ffree-line-length-none -fcheck=all -fbacktrace -fbounds-check -fbacktrace -fallow-invalid-boz -fPIC ${CMAKE_Fortran_FLAGS}" )
set ( CMAKE_C_FLAGS "-g -O3 ${CMAKE_C_FLAGS}" )

set ( Fortran_FLAGS_ARE_SET ON )
