# CMake project file for orderpack2
cmake_minimum_required (VERSION 2.6)

# Allows to set project version
cmake_policy(SET CMP0048 NEW)
project (orderpack2 VERSION 2.0)

# Which languages do we use
enable_language (Fortran)

# Set the CMAKE_MODULE_PATH
LIST (APPEND CMAKE_MODULE_PATH $ENV{CMAKE_MACROS})

# Set library name
set(LIBRARY_NAME orderpack2)

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

# Whether you build a static or shared library
set(LIBRARY_TYPE SHARED)
if (CMAKE_LIBRARY_TYPE)
  set(LIBRARY_TYPE ${CMAKE_LIBRARY_TYPE})
endif (CMAKE_LIBRARY_TYPE)

if (${LIBRARY_TYPE} STREQUAL "STATIC")
  set (CMAKE_LIBRARY_PREFIX ${CMAKE_STATIC_LIBRARY_PREFIX} CACHE INTERNAL "Prefix for CMake libraries")
  set (CMAKE_LIBRARY_SUFFIX ${CMAKE_STATIC_LIBRARY_SUFFIX} CACHE INTERNAL "Suffix for CMake libraries")
elseif (${LIBRARY_TYPE} STREQUAL "SHARED")
  set (CMAKE_LIBRARY_PREFIX ${CMAKE_SHARED_LIBRARY_PREFIX} CACHE INTERNAL "Prefix for CMake libraries")
  set (CMAKE_LIBRARY_SUFFIX ${CMAKE_SHARED_LIBRARY_SUFFIX} CACHE INTERNAL "Suffix for CMake libraries")
endif (${LIBRARY_TYPE} STREQUAL "STATIC")

# Library installation directory
set (CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)

# Header files installation directory
set (CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/orderpack2)

# Binary files installation directory
set (CMAKE_BINDIR ${CMAKE_INSTALL_PREFIX}/bin)

# Set installation directory for *mod files
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files)

# Pre-processing of source files (e.g. with fypp or C preprocessor)
# Source files used to build the library
FILE(GLOB SRC_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/*.f90 ${CMAKE_CURRENT_SOURCE_DIR}/*.F90)

# Command to build the library
add_library(
  ${LIBRARY_NAME}
  ${LIBRARY_TYPE} 
  ${SRC_FILES}
)

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

set ( ORDERPACK2_INCLUDE_DIR "${CMAKE_INCLUDEDIR}" CACHE INTERNAL "orderpack2 include directory" )
set ( ORDERPACK2_LIBRARIES_DIR "${CMAKE_LIBDIR}" CACHE INTERNAL "orderpack2 library directory" )
set ( ORDERPACK2_LIBRARIES "${LIBRARY_NAME}" CACHE INTERNAL "orderpack2 library" )
