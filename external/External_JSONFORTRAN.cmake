# An external project for JSONFORTRAN
set ( JSONFORTRAN_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set (JSONFORTRAN_SOURCE  ${JSONFORTRAN_PREFIX}/jsonfortran-src)
set (JSONFORTRAN_BINARY  ${JSONFORTRAN_PREFIX}/jsonfortran)
set (JSONFORTRAN_INSTALL ${CMAKE_INSTALL_PREFIX})

set (JSONFORTRAN_LIBRARY_NAME jsonfortran)
set (JSONFORTRAN_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (JSONFORTRAN_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${JSONFORTRAN_LIBRARY_NAME})

ExternalProject_Add(
  EXT_JSONFORTRAN
  DOWNLOAD_DIR ${JSONFORTRAN_PREFIX}
  SOURCE_DIR ${JSONFORTRAN_SOURCE}
  BINARY_DIR ${JSONFORTRAN_BINARY}
  INSTALL_DIR ${JSONFORTRAN_INSTALL}
  URL ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/archives/json-fortran-5.1.0.tar.gz
  #GIT_REPOSITORY https://github.com/jacobwilliams/json-fortran
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DUSE_GNU_INSTALL_CONVENTION=ON -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> - DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH}
  )

set ( JSONFORTRAN_INCLUDE_DIR ${JSONFORTRAN_CMAKE_INCLUDEDIR} CACHE INTERNAL "JSONFORTRAN include directory" )
set ( JSONFORTRAN_LIBRARIES "${JSONFORTRAN_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${JSONFORTRAN_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "JSONFORTRAN library" )
