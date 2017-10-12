# An external project for MCFOR
set ( MCFOR_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set ( MCFOR_SOURCE  ${MCFOR_PREFIX}/mcfor-src )
set ( MCFOR_BINARY  ${MCFOR_PREFIX}/mcfor )
set ( MCFOR_INSTALL ${CMAKE_INSTALL_PREFIX} )

set (MCFOR_LIBRARY_NAME mcfor)
set (MCFOR_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (MCFOR_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${MCFOR_LIBRARY_NAME})

if (SHIPPABLE)
  set (GIT_MCFOR "git@github.com:jacopo-chevallard/mcfor.git")
else (SHIPPABLE)
  set (GIT_MCFOR "https://github.com/jacopo-chevallard/mcfor.git")
endif(SHIPPABLE)

if (mcfor_version)

  ExternalProject_Add(
    EXT_${MCFOR_LIBRARY_NAME}
    DOWNLOAD_DIR ${MCFOR_PREFIX}
    SOURCE_DIR ${MCFOR_SOURCE}
    BINARY_DIR ${MCFOR_BINARY}
    INSTALL_DIR ${MCFOR_INSTALL}
    GIT_REPOSITORY ${GIT_MCFOR}
    GIT_TAG 0.5.0
    CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
    )

else (mcfor_version)

  ExternalProject_Add(
    EXT_${MCFOR_LIBRARY_NAME}
    DOWNLOAD_DIR ${MCFOR_PREFIX}
    SOURCE_DIR ${MCFOR_SOURCE}
    BINARY_DIR ${MCFOR_BINARY}
    INSTALL_DIR ${MCFOR_INSTALL}
    GIT_REPOSITORY ${GIT_MCFOR}
    CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
    )

endif (mcfor_version)

set ( MCFOR_INCLUDE_DIR ${MCFOR_CMAKE_INCLUDEDIR} CACHE INTERNAL "MCFOR include directory" )
set ( MCFOR_LIBRARIES "${MCFOR_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${MCFOR_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "MCFOR library" )


