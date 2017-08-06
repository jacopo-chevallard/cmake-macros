# An external project for DIVER
set ( DIVER_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set (DIVER_SOURCE  ${DIVER_PREFIX}/diver-src)
set (DIVER_BINARY  ${DIVER_PREFIX}/diver)
set (DIVER_INSTALL ${CMAKE_INSTALL_PREFIX})

set (DIVER_LIBRARY_NAME diver)
set (DIVER_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (DIVER_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${DIVER_LIBRARY_NAME})

ExternalProject_Add(
  EXT_diver
  DOWNLOAD_DIR ${DIVER_PREFIX}
  SOURCE_DIR ${DIVER_SOURCE}
  BINARY_DIR ${DIVER_BINARY}
  INSTALL_DIR ${DIVER_INSTALL}
  URL $ENV{CMAKE_DEPENDENCIES}/archives/Diver-74529682.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/diver/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE} -DSHIPPABLE=${SHIPPABLE}
  )

set ( DIVER_INCLUDE_DIR ${DIVER_CMAKE_INCLUDEDIR} CACHE INTERNAL "DIVER include directory" )
set ( DIVER_LIBRARIES "${DIVER_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${DIVER_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "DIVER library" )