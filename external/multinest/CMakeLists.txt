# CMake project file for multinest
cmake_minimum_required (VERSION 2.6)

# Allows to set project version
cmake_policy(SET CMP0048 NEW)
project (multinest VERSION 3.9)

# Which languages do we use
enable_language (Fortran)

# Set the CMAKE_MODULE_PATH
LIST (APPEND CMAKE_MODULE_PATH $ENV{CMAKE_MACROS})

include( libFindGeneral )

# Include default flags for Fortran and C compiler
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
set(LIBRARY_NAME multinest)

# Whether you build a static or shared library
set(LIBRARY_TYPE SHARED)
if (CMAKE_LIBRARY_TYPE)
  set(LIBRARY_TYPE ${CMAKE_LIBRARY_TYPE})
endif (CMAKE_LIBRARY_TYPE)

# Library installation directory
set (CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)

# Header files installation directory
set (CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/multinest)

# Binary files installation directory
set (CMAKE_BINDIR ${CMAKE_INSTALL_PREFIX}/bin)

# Set installation directory for *mod files
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files)

# Source files used to build the library
FILE(GLOB SRC_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/*.f90 ${CMAKE_CURRENT_SOURCE_DIR}/*.F90 ${CMAKE_CURRENT_SOURCE_DIR}/*.f90)

# Command to build the library
add_library(
  ${LIBRARY_NAME}
  ${LIBRARY_TYPE} 
  ${SRC_FILES}
)

libfind_detect ( OpenBLAS FIND_LIBRARY openblas LIBRARY_DIRS ${CMAKE_INSTALL_PREFIX}/lib NO_DEFAULT_PATH ${CMAKE_NO_DEFAULT_PATH} )

# Link the library
target_link_libraries ( ${LIBRARY_NAME} 
  ${OpenBLAS_LIBRARIES}
)

# Location of the libraries
link_directories( ${OpenBLAS_LIBRARIES_DIR})

# install library
install(
  TARGETS ${LIBRARY_NAME} 
  ARCHIVE DESTINATION ${CMAKE_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_LIBDIR}
)

# install header (*mod) files
install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ 
  DESTINATION ${CMAKE_INCLUDEDIR}
)

# configure a number version file to pass some of the CMake settings
# to the source code
configure_file(
  $ENV{CMAKE_MACROS}/pkg-config.pc.cmake
  ${CMAKE_CURRENT_SOURCE_DIR}/${LIBRARY_NAME}.pc
  @ONLY
)

# install configuration file
install(
  FILES ${CMAKE_CURRENT_SOURCE_DIR}/${LIBRARY_NAME}.pc
  DESTINATION ${CMAKE_LIBDIR}/pkgconfig
  )

set_target_properties(
  ${LIBRARY_NAME}
  PROPERTIES COMPILE_FLAGS "${Fortran_FLAGS} ${CMAKE_Fortran_COMPILER_FLAGS}"
  )

set ( MULTINEST_INCLUDE_DIR "${CMAKE_INCLUDEDIR}" CACHE INTERNAL "multinest include directory" )
set ( MULTINEST_LIBRARIES_DIR "${CMAKE_LIBDIR}" CACHE INTERNAL "multinest library directory" )
set ( MULTINEST_LIBRARIES "${LIBRARY_NAME}" CACHE INTERNAL "multinest library" )
