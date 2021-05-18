# An external project for FPL
set (FPL_PREFIX ${CMAKE_BINARY_DIR}/dependencies)

set (FPL_SOURCE  ${FPL_PREFIX}/fpl-src)
set (FPL_BINARY  ${FPL_PREFIX}/fpl)
set (FPL_INSTALL ${CMAKE_INSTALL_PREFIX})

set (FPL_LIBRARY_NAME fpl)
set (FPL_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (FPL_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${FPL_LIBRARY_NAME})

ExternalProject_Add(
  EXT_fpl
  DOWNLOAD_DIR ${FPL_PREFIX}
  SOURCE_DIR ${FPL_SOURCE}
  BINARY_DIR ${FPL_BINARY}
  INSTALL_DIR ${FPL_INSTALL}
  URL $ENV{CMAKE_DEPENDENCIES}/archives/fpl.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/fpl/src/lib/CMakeLists.txt <SOURCE_DIR>/src/lib
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}

  )

set (FPL_INCLUDE_DIR ${FPL_CMAKE_INCLUDEDIR} CACHE INTERNAL "FPL include directory" )
set (FPL_LIBRARIES "${FPL_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${FPL_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "FPL library")
