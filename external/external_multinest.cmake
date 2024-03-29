# An external project for MULTINEST
set ( MULTINEST_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set (MULTINEST_SOURCE  ${MULTINEST_PREFIX}/multinest-src)
set (MULTINEST_BINARY  ${MULTINEST_PREFIX}/multinest)
set (MULTINEST_INSTALL ${CMAKE_INSTALL_PREFIX})

set (MULTINEST_LIBRARY_NAME multinest)
set (MULTINEST_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (MULTINEST_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${MULTINEST_LIBRARY_NAME})

ExternalProject_Add(
  EXT_multinest
  DOWNLOAD_DIR ${MULTINEST_PREFIX}
  SOURCE_DIR ${MULTINEST_SOURCE}
  BINARY_DIR ${MULTINEST_BINARY}
  INSTALL_DIR ${MULTINEST_INSTALL}
  URL $ENV{CMAKE_DEPENDENCIES}/archives/MultiNest_v3.9.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/multinest/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( MULTINEST_INCLUDE_DIR ${MULTINEST_CMAKE_INCLUDEDIR} CACHE INTERNAL "MULTINEST include directory" )
set ( MULTINEST_LIBRARIES "${MULTINEST_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${MULTINEST_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "MULTINEST library" )
