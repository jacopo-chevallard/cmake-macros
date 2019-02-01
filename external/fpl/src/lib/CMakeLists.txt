# CMake project file for fpl
cmake_minimum_required (VERSION 2.6)

# Allows to set project version
cmake_policy(SET CMP0048 NEW)
project (fpl)

# Set library name
set(LIBRARY_NAME fpl)

# Which languages do we use
enable_language (Fortran C)

# Set the CMAKE_MODULE_PATH
LIST (APPEND CMAKE_MODULE_PATH $ENV{CMAKE_MACROS})
LIST (APPEND CMAKE_MODULE_PATH "$ENV{CMAKE_MACROS}/external")

# Set flag for Shippable CD/CI
if (SHIPPABLE)
  set (SHIPPABLE ON CACHE INTERNAL "Flag for Shippable CD/CI")
  set (SHIPPABLE_SUFFIX "_Shippable" CACHE INTERNAL "Suffix for file versions tailored at working with Shippable CI/CD")
endif (SHIPPABLE)

include(ExternalProject)
include(libFindGeneral)
include(parseDependencies)

# Probelms with RPATH
if ( NOT RPATH_CONFIG )
  include ( General_rpath_config ) 
endif ( NOT RPATH_CONFIG )

# Include default flags for Fortran and C compiler
if ( NOT Fortran_FLAGS_ARE_SET )
  if ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )
    include( GNU_Fortran_Flags )
  elseif ( CMAKE_Fortran_COMPILER_ID STREQUAL Intel )
    include( Intel_Fortran_Flags )
  endif ( CMAKE_Fortran_COMPILER_ID STREQUAL GNU )
endif ( NOT Fortran_FLAGS_ARE_SET )

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
set (CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${LIBRARY_NAME})

# Binary files installation directory
set (CMAKE_BINDIR ${CMAKE_INSTALL_PREFIX}/bin)

# Set installation directory for *mod files
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files)

# Source files used to build the library
#FILE(GLOB_RECURSE SRC_FILES *.f90 *.F90 *.c)
#FILE(GLOB_RECURSE SRC_FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/lib/*.f90 ${CMAKE_CURRENT_SOURCE_DIR}/src/lib/*.F90 ${CMAKE_CURRENT_SOURCE_DIR}/src/lib/*.c)
FILE(GLOB_RECURSE SRC_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/*.f90 ${CMAKE_CURRENT_SOURCE_DIR}/*.F90 ${CMAKE_CURRENT_SOURCE_DIR}/*.c)

# Command to build the library
add_library(
  ${LIBRARY_NAME}
  ${LIBRARY_TYPE} 
  ${SRC_FILES}
)

find_dependencies(DEPENDENCIES_LIST penf%penf.mod)

if (NOT PENF_FOUND)
  if (NOT TARGET EXT_penf)
    include(external_penf)
    add_dependencies (${LIBRARY_NAME} EXT_penf)
  endif (NOT TARGET EXT_penf)
endif (NOT PENF_FOUND)

set(include_directories_list ${include_directories_list} "${PENF_INCLUDE_DIR}")
set(target_link_libraries_list ${target_link_libraries_list} "${PENF_LIBRARIES}")

# Link the library
target_link_libraries ( 
  ${LIBRARY_NAME} 
  ${target_link_libraries_list}
)

include_directories( ${include_directories_list})

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

set ( FPL_INCLUDE_DIR "${CMAKE_INCLUDEDIR}" CACHE INTERNAL "fpl include directory" )
set ( FPL_LIBRARIES_DIR "${CMAKE_LIBDIR}" CACHE INTERNAL "fpl library directory" )
set ( FPL_LIBRARIES "${LIBRARY_NAME}" CACHE INTERNAL "fpl library" )
