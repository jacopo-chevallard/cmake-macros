# An external project for ORDERPACK2
set ( ORDERPACK2_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set (ORDERPACK2_SOURCE  ${ORDERPACK2_PREFIX}/orderpack2-src)
set (ORDERPACK2_BINARY  ${ORDERPACK2_PREFIX}/orderpack2)
set (ORDERPACK2_INSTALL ${CMAKE_INSTALL_PREFIX})

set (ORDERPACK2_LIBRARY_NAME orderpack2)
set (ORDERPACK2_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (ORDERPACK2_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${ORDERPACK2_LIBRARY_NAME})

ExternalProject_Add(
  EXT_orderpack2
  DOWNLOAD_DIR ${ORDERPACK2_PREFIX}
  SOURCE_DIR ${ORDERPACK2_SOURCE}
  BINARY_DIR ${ORDERPACK2_BINARY}
  INSTALL_DIR ${ORDERPACK2_INSTALL}
  URL $ENV{CMAKE_DEPENDENCIES}/archives/orderpack2.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/orderpack2/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( ORDERPACK2_INCLUDE_DIR ${ORDERPACK2_CMAKE_INCLUDEDIR} CACHE INTERNAL "ORDERPACK2 include directory" )
set ( ORDERPACK2_LIBRARIES "${ORDERPACK2_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${ORDERPACK2_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "ORDERPACK2 library" )
