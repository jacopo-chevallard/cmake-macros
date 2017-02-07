# An external project for BeFoR64
# URL https://github.com/szaghi/BeFoR64
set ( BEFOR64_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set ( BEFOR64_SOURCE  ${BEFOR64_PREFIX}/befor64-src )
set ( BEFOR64_BINARY  ${BEFOR64_PREFIX}/befor64 )
set ( BEFOR64_INSTALL ${CMAKE_INSTALL_PREFIX} )

set (BEFOR64_LIBRARY_NAME befor64)
set (BEFOR64_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (BEFOR64_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${BEFOR64_LIBRARY_NAME})

ExternalProject_Add(
  EXT_befor64
  DOWNLOAD_DIR ${BEFOR64_PREFIX}
  SOURCE_DIR ${BEFOR64_SOURCE}
  BINARY_DIR ${BEFOR64_BINARY}
  INSTALL_DIR ${BEFOR64_INSTALL}
  URL $ENV{CMAKE_DEPENDENCIES}/archives/BeFoR64-1.1.1.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/befor64/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( BEFOR64_INCLUDE_DIR ${BEFOR64_CMAKE_INCLUDEDIR} CACHE INTERNAL "BEFOR64 include directory" )
set ( BEFOR64_LIBRARIES "${BEFOR64_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${BEFOR64_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "BEFOR64 library" )