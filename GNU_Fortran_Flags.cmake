MESSAGE ( STATUS "Adding default compiler flags for GNU compiler")
#set ( CMAKE_Fortran_FLAGS "-DLAPACK -g -O0 -cpp -fcheck=all -fbacktrace -fbounds-check -ffree-line-length-none -fPIC -fallow-invalid-boz -fallow-argument-mismatch -Wimplicit-function-declaration ${CMAKE_Fortran_FLAGS}" )
set ( CMAKE_Fortran_FLAGS "-DLAPACK -g -O2 -cpp  -fbounds-check -ffree-line-length-none -fbacktrace -fallow-argument-mismatch -fallow-invalid-boz -Wimplicit-function-declaration -fPIC ${CMAKE_Fortran_FLAGS}" )
set ( CMAKE_C_FLAGS "-g -O3 -w ${CMAKE_C_FLAGS}" )

set ( Fortran_FLAGS_ARE_SET ON )
