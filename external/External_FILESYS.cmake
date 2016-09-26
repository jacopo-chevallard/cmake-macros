# An external project for FILESYS
# URL https://bitbucket.org/aradi/fortyxima/
set ( FILESYS_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set ( FILESYS_SOURCE  ${FILESYS_PREFIX}/filesys-src )
set ( FILESYS_BINARY  ${FILESYS_PREFIX}/filesys )
set ( FILESYS_INSTALL ${CMAKE_INSTALL_PREFIX} )

set(FILESYS_LIBRARY_NAME filesys)
set (FILESYS_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (FILESYS_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${FILESYS_LIBRARY_NAME})

ExternalProject_Add(
  EXT_FILESYS
  DOWNLOAD_DIR ${FILESYS_PREFIX}
  SOURCE_DIR ${FILESYS_SOURCE}
  BINARY_DIR ${FILESYS_BINARY}
  INSTALL_DIR ${FILESYS_INSTALL}
  URL ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/archives/filesys-0.1.0.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/filesys/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( FILESYS_INCLUDE_DIR ${FILESYS_CMAKE_INCLUDEDIR} CACHE INTERNAL "FILESYS include directory" )
set ( FILESYS_LIBRARIES "${FILESYS_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${FILESYS_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "FILESYS library" )
