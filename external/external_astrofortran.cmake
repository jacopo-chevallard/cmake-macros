# An external project for ASTROFORTRAN
set ( ASTROFORTRAN_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set ( ASTROFORTRAN_SOURCE  ${ASTROFORTRAN_PREFIX}/astrofortran-src )
set ( ASTROFORTRAN_BINARY  ${ASTROFORTRAN_PREFIX}/astrofortran )
set ( ASTROFORTRAN_INSTALL ${CMAKE_INSTALL_PREFIX} )

set(ASTROFORTRAN_LIBRARY_NAME astrofortran)
set (ASTROFORTRAN_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (ASTROFORTRAN_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${ASTROFORTRAN_LIBRARY_NAME})

if (JFROG)
  set (GIT_ASTROFORTRAN "https://${JFROG_TOKEN}:x-oauth-basic@github.com/jacopo-chevallard/astrofortran.git")
else ()
  set (GIT_ASTROFORTRAN "https://github.com/jacopo-chevallard/astrofortran.git")
endif()

if (astrofortran_version)

  ExternalProject_Add(
    EXT_${ASTROFORTRAN_LIBRARY_NAME}
    DOWNLOAD_DIR ${ASTROFORTRAN_PREFIX}
    SOURCE_DIR ${ASTROFORTRAN_SOURCE}
    BINARY_DIR ${ASTROFORTRAN_BINARY}
    INSTALL_DIR ${ASTROFORTRAN_INSTALL}
    GIT_REPOSITORY ${GIT_ASTROFORTRAN}
    GIT_TAG ${astrofortran_version}
    CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE} -DUSE_HTTPS=${USE_HTTPS} -DENABLE_LIBUNWIND=${ENABLE_LIBUNWIND} 
    )

else (astrofortran_version)

  ExternalProject_Add(
    EXT_${ASTROFORTRAN_LIBRARY_NAME}
    DOWNLOAD_DIR ${ASTROFORTRAN_PREFIX}
    SOURCE_DIR ${ASTROFORTRAN_SOURCE}
    BINARY_DIR ${ASTROFORTRAN_BINARY}
    INSTALL_DIR ${ASTROFORTRAN_INSTALL}
    GIT_REPOSITORY ${GIT_ASTROFORTRAN}
    CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE} -DUSE_HTTPS=${USE_HTTPS} -DENABLE_LIBUNWIND=${ENABLE_LIBUNWIND} 
    )

endif (astrofortran_version)

set ( ASTROFORTRAN_INCLUDE_DIR ${ASTROFORTRAN_CMAKE_INCLUDEDIR} CACHE INTERNAL "ASTROFORTRAN include directory" )
set ( ASTROFORTRAN_LIBRARIES "${ASTROFORTRAN_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${ASTROFORTRAN_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "ASTROFORTRAN library" )

