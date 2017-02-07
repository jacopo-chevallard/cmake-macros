# An external project for StringiFor
# URL https://github.com/szaghi/StringiFor
set ( STRINGIFOR_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set ( STRINGIFOR_SOURCE  ${STRINGIFOR_PREFIX}/stringifor-src )
set ( STRINGIFOR_BINARY  ${STRINGIFOR_PREFIX}/stringifor )
set ( STRINGIFOR_INSTALL ${CMAKE_INSTALL_PREFIX} )

set (STRINGIFOR_LIBRARY_NAME stringifor)
set (STRINGIFOR_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (STRINGIFOR_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${STRINGIFOR_LIBRARY_NAME})

ExternalProject_Add(
  EXT_stringifor
  DOWNLOAD_DIR ${STRINGIFOR_PREFIX}
  SOURCE_DIR ${STRINGIFOR_SOURCE}
  BINARY_DIR ${STRINGIFOR_BINARY}
  INSTALL_DIR ${STRINGIFOR_INSTALL}
  URL $ENV{CMAKE_DEPENDENCIES}/archives/StringiFor-0.9.4.tar.gz
  PATCH_COMMAND cp $ENV{CMAKE_MACROS}/external/stringifor/CMakeLists.txt <SOURCE_DIR>
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( STRINGIFOR_INCLUDE_DIR ${STRINGIFOR_CMAKE_INCLUDEDIR} CACHE INTERNAL "STRINGIFOR include directory" )
set ( STRINGIFOR_LIBRARIES "${STRINGIFOR_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${STRINGIFOR_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "STRINGIFOR library" )
