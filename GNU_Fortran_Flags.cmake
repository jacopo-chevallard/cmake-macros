MESSAGE ( STATUS "Adding default compiler flags for GNU compiler")
#set ( CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -DLAPACK -Wall -g -O0 -cpp -pedantic -fcheck=all -Wextra -fbacktrace -fbounds-check -ffree-line-length-none" )
set ( CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -DLAPACK -g -O3 -cpp -ffree-line-length-none -fbacktrace -fno-pie" )
set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O3" )

set ( Fortran_FLAGS_ARE_SET ON )
