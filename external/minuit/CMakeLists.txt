cmake_minimum_required(VERSION 2.8) 
project ( minuit )
enable_language( Fortran )

LIST ( APPEND CMAKE_MODULE_PATH "${CMAKE_PARENT_SOURCE_DIR}/cmake" )

if ( NOT RPATH_CONFIG )
  include ( General_rpath_config ) 
endif ( NOT RPATH_CONFIG )

# Source files used to build the library
FILE(GLOB SRC_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
      "${CMAKE_CURRENT_SOURCE_DIR}/*.F")

    LIST(REMOVE_ITEM SRC_FILES intract.F)

# Set library name
set ( LIBRARY_NAME minuit )

# Where do we put the *mod files created during compilation?
set ( CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod_files )

# Build the library
add_library(
  ${LIBRARY_NAME}
  SHARED 
  ${SRC_FILES}
)

# Install the library and *mod (header) files
install(
  TARGETS ${LIBRARY_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  )

install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/
  DESTINATION include
)


# Testing routine
#enable_testing( )

#add_executable( test test_orderpack.f90 )
#target_link_libraries( test ${LIBRARY_NAME} )
#add_test( test test )
