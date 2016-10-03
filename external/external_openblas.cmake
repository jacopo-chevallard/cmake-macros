# An external project for BLAS/OpenBLAS
# http://www.openblas.net
set ( OpenBLAS_PREFIX "${CMAKE_BINARY_DIR}/dependencies" )

set ( OpenBLAS_SOURCE  "${OpenBLAS_PREFIX}/openblas-src" )
set ( OpenBLAS_BINARY  "${OpenBLAS_PREFIX}/openblas" )
set ( OpenBLAS_INSTALL ${CMAKE_INSTALL_PREFIX} )

set (OpenBLAS_LIBRARY_NAME openblas)
set (OpenBLAS_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (OpenBLAS_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include)

ExternalProject_Add(
  EXT_openblas
  DOWNLOAD_DIR ${OpenBLAS_PREFIX}
  SOURCE_DIR ${OpenBLAS_SOURCE}
  INSTALL_DIR ${OpenBLAS_INSTALL}
  #GIT_REPOSITORY https://github.com/xianyi/OpenBLAS.git
  #GIT_TAG v0.2.14
  URL $ENV{CMAKE_DEPENDENCIES}/archives/OpenBLAS-0.2.18.tar.gz
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ""
  BUILD_COMMAND make CC=${CMAKE_C_COMPILER} FC=${CMAKE_Fortran_COMPILER} HOSTCC=${CMAKE_C_COMPILER}
  INSTALL_COMMAND make install PREFIX=<INSTALL_DIR>
  )

set ( OpenBLAS_INCLUDE_DIR ${OpenBLAS_CMAKE_INCLUDEDIR} CACHE INTERNAL "OpenBLAS include directory" )
set ( OpenBLAS_LIBRARIES "${OpenBLAS_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${OpenBLAS_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "OpenBLAS library" )

# Set package version number
set ( OpenBLAS_VERSION_MAJOR 0 CACHE INTERNAL "OpenBLAS major version number" )
set ( OpenBLAS_VERSION_MINOR 2 CACHE INTERNAL "OpenBLAS minor version number" )
set ( OpenBLAS_VERSION_PATCH 18 CACHE INTERNAL "OpenBLAS patch version number" )
