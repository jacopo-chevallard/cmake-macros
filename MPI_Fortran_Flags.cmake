MESSAGE ( STATUS "Adding default compiler flags for using MPI")
set ( CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -cpp -DMPI" )
