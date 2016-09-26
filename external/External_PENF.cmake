# An external project for PENF
# URL https://github.com/szaghi/PENF
set ( PENF_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set ( PENF_SOURCE  ${PENF_PREFIX}/penf-src )
set ( PENF_BINARY  ${PENF_PREFIX}/penf )
set ( PENF_INSTALL ${CMAKE_INSTALL_PREFIX} )

set (PENF_LIBRARY_NAME penf)
set (PENF_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (PENF_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${PENF_LIBRARY_NAME})

ExternalProject_Add(
  EXT_PENF
  DOWNLOAD_DIR ${PENF_PREFIX}
  SOURCE_DIR ${PENF_SOURCE}
  BINARY_DIR ${PENF_BINARY}
  INSTALL_DIR ${PENF_INSTALL}
  URL ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/archives/PENF-1.1.2.tar
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/penf/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( PENF_INCLUDE_DIR ${PENF_CMAKE_INCLUDEDIR} CACHE INTERNAL "PENF include directory" )
set ( PENF_LIBRARIES "${PENF_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${PENF_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "PENF library" )