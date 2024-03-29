# An external project for NLOPT
set ( NLOPT_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set (NLOPT_SOURCE  ${NLOPT_PREFIX}/nlopt-src)
set (NLOPT_BINARY  ${NLOPT_PREFIX}/nlopt)
set (NLOPT_INSTALL ${CMAKE_INSTALL_PREFIX})

set (NLOPT_LIBRARY_NAME nlopt)
set (NLOPT_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (NLOPT_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${NLOPT_LIBRARY_NAME})

ExternalProject_Add(
  EXT_nlopt
  DOWNLOAD_DIR ${NLOPT_PREFIX}
  SOURCE_DIR ${NLOPT_SOURCE}
  BINARY_DIR ${NLOPT_BINARY}
  INSTALL_DIR ${NLOPT_INSTALL}
  URL $ENV{CMAKE_DEPENDENCIES}/archives/nlopt.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/nlopt/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( NLOPT_INCLUDE_DIR ${NLOPT_CMAKE_INCLUDEDIR} CACHE INTERNAL "NLOPT include directory" )
set ( NLOPT_LIBRARIES "${NLOPT_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${NLOPT_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "NLOPT library" )
