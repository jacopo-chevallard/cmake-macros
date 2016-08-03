# Avoid useless copy&pasta by doing what most simple libraries do anyway:
# pkg-config, find headers, find library.
# Usage: libfind_pkg_detect( <prefix> FIND_PATH <name> [other args] INCLUDE_DIRS <path> FIND_LIBRARY <name> LIBRARY_DIRS <path> NO_DEFAULT_PATH <ON/OFF> )
# E.g. libfind_detect ( FFTW3 FIND_PATH fftw3.h INCLUDE_DIRS ${CMAKE_INSTALL_PREFIX}/include FIND_LIBRARY fftw3 LIBRARY_DIRS ${CMAKE_INSTALL_PREFIX}/lib NO_DEFAULT_PATH ON )

function ( libfind_detect PREFIX )

  # Parse arguments

  foreach (i ${ARGN})

    if ("${i}" STREQUAL "FIND_PATH")
      set( argname pathargs )
    elseif ("${i}" STREQUAL "FIND_LIBRARY")
      set( argname libraryargs )
    elseif ("${i}" STREQUAL "INCLUDE_DIRS")
      set( argname includedirs )
    elseif ("${i}" STREQUAL "LIBRARY_DIRS")
      set( argname librarydirs )
    elseif ("${i}" STREQUAL "NO_DEFAULT_PATH")
      set( argname NO_DEFAULT_PATH )
    else()
      set(${argname} ${${argname}} ${i})
    endif()

  endforeach()

  # Find header files directory
  if ( pathargs )

    if ( NO_DEFAULT_PATH )
      find_path( ${PREFIX}_INCLUDE_DIR NAMES ${pathargs} PATHS ${includedirs} NO_DEFAULT_PATH )
    else ( NO_DEFAULT_PATH )
      find_path( ${PREFIX}_INCLUDE_DIR NAMES ${pathargs} PATHS ${includedirs} )
    endif ( NO_DEFAULT_PATH )

  endif ( pathargs )

  # Find library directory
  if ( libraryargs )

    if ( NO_DEFAULT_PATH )
      find_library( ${PREFIX}_LIBRARIES NAMES ${libraryargs} PATHS ${librarydirs} NO_DEFAULT_PATH )
    else ( NO_DEFAULT_PATH )
      find_library( ${PREFIX}_LIBRARIES NAMES ${libraryargs} PATHS ${librarydirs} )
    endif ( NO_DEFAULT_PATH )

    get_filename_component( ${PREFIX}_LIBRARIES_DIR ${${PREFIX}_LIBRARIES} PATH )

  endif( libraryargs )

  # Check if you found what you were searching for
  if ( pathargs AND libraryargs ) 

    if ( ${PREFIX}_INCLUDE_DIR AND ${PREFIX}_LIBRARIES )
      set ( ${PREFIX}_FOUND TRUE PARENT_SCOPE ) 
    endif ( ${PREFIX}_INCLUDE_DIR AND ${PREFIX}_LIBRARIES )

  elseif( pathargs )

    if ( ${PREFIX}_INCLUDE_DIR )
      set ( ${PREFIX}_FOUND TRUE PARENT_SCOPE ) 
    endif ( ${PREFIX}_INCLUDE_DIR )

  elseif( libraryargs )

    if ( ${PREFIX}_LIBRARIES )
      set ( ${PREFIX}_FOUND TRUE PARENT_SCOPE ) 
    endif ( ${PREFIX}_LIBRARIES )

  endif ( pathargs AND libraryargs ) 

  # Communicate the result of the search
  if ( ${PREFIX}_FOUND )
    MESSAGE(STATUS "Found ${PREFIX}_LIBRARIES: ${${PREFIX}_LIBRARIES}")
  endif ( ${PREFIX}_FOUND )

endfunction()
