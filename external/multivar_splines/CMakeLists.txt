# CMake project file for MultiVar_splines
cmake_minimum_required ( VERSION 2.6 )
project ( MultiVar_splines )
enable_language ( Fortran )

# Set the CMAKE_MODULE_PATH
LIST ( APPEND CMAKE_MODULE_PATH "${CMAKE_PARENT_SOURCE_DIR}/cmake" )

# Check that when using GNU Fortran the free form flag is passed
if ( NOT Fortran_FLAGS_ARE_SET )
  if ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )
    include( GNU_Fortran_Flags )
  elseif ( CMAKE_Fortran_COMPILER_ID STREQUAL Intel )
    include( Intel_Fortran_Flags )
  endif ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )
endif ( NOT Fortran_FLAGS_ARE_SET )

if ( NOT RPATH_CONFIG )
  include ( General_rpath_config ) 
endif ( NOT RPATH_CONFIG )

# Set library name
set(LIBRARY_NAME multivar_splines)

# Set installation directory for *mod files
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files)

# Source files used to build the library
SET (SRC_FILES
  b1ink.f
  b1val.f
  b2ink.f
  b2val.f
  b3ink.f
  b3val.f
  bintk.f
  bknot.f
  bnfac.f
  bnslv.f
  bspvn.f
  btpcf.f
  bvalu.f
  db1ink.f
  db1val.f
  db2ink.f
  db2val.f
  db3ink.f
  db3val.f
  dbintk.f
  dbknot.f
  dbnfac.f
  dbnslv.f
  dbspvn.f
  dbtpcf.f
  dbvalu.f
  dintrv.f
  fdump.f
  i1mach.f
  intrv.f
  j4save.f
  xerabt.f
  xerctl.f
  xerprt.f
  xerror.f
  xerrwv.f
  xersav.f
  xgetua.f
  multivariate_splines.f90
  )

# Command to build the library
add_library(
  ${LIBRARY_NAME}
  SHARED
  ${SRC_FILES}
)

# install library
install(
  TARGETS ${LIBRARY_NAME} 
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)

# install header (*mod) files
install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ 
  DESTINATION include/${LIBRARY_NAME}
)

set_target_properties(
  ${LIBRARY_NAME}
  PROPERTIES COMPILE_FLAGS "${CMAKE_Fortran_COMPILER_FLAGS}"
  )

set ( MULTIVAR_SPLINES_INCLUDE_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE INTERNAL "MULTIVAR_SPLINES include directory" )
set ( MULTIVAR_SPLINES_LIBRARIES_DIR "${CMAKE_INSTALL_PREFIX}/lib" CACHE INTERNAL "MULTIVAR_SPLINES library directory" )
set ( MULTIVAR_SPLINES_LIBRARIES "${LIBRARY_NAME}" CACHE INTERNAL "MULTIVAR_SPLINES library" )

# set the path to the library folder
#link_directories( lib )

add_executable ( test test.f90 )

# link the libraries to the executable
target_link_libraries ( test ${LIBRARY_NAME} )

# include dir
#include_directories( include )

enable_testing( )

add_test ( test test )