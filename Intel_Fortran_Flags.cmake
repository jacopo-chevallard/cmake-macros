MESSAGE ( STATUS "Adding default compiler flags for Intel compiler")
#set ( CMAKE_VERBOSE_MAKEFILE ON )
#set ( CMAKE_Fortran_FLAGS "-DLAPACK -g -O0 -cpp -heap-arrays -check all -debug all -ftrapuv  -gen-interfaces -warn interfaces -warn unused -traceback ${CMAKE_Fortran_FLAGS}" )
set ( CMAKE_Fortran_FLAGS "-DLAPACK -g -O2 -cpp -xHost -heap-arrays ${CMAKE_Fortran_FLAGS}" )
set ( CMAKE_C_FLAGS "-g -O3 ${CMAKE_C_FLAGS}" )

# *************** FOR GINA: START ****************
#set ( CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -g -O3 -xHost -heap-arrays" )
#set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O3 -xHost -heap-arrays -gcc-name=/sto/home/chevalla/bin/gcc -shared-libgcc -g++-name=/sto/home/chevalla/bin/g++ " )
# *************** FOR GINA: END ****************

set ( Fortran_FLAGS_ARE_SET ON )
