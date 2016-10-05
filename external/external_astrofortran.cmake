# An external project for ASTROFORTRAN
set ( ASTROFORTRAN_PREFIX ${CMAKE_BINARY_DIR}/dependencies )

set ( ASTROFORTRAN_SOURCE  ${ASTROFORTRAN_PREFIX}/astrofortran-src )
set ( ASTROFORTRAN_BINARY  ${ASTROFORTRAN_PREFIX}/astrofortran )
set ( ASTROFORTRAN_INSTALL ${CMAKE_INSTALL_PREFIX} )

set(ASTROFORTRAN_LIBRARY_NAME astrofortran)
set (ASTROFORTRAN_CMAKE_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set (ASTROFORTRAN_CMAKE_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${ASTROFORTRAN_LIBRARY_NAME})

if (SHIPPABLE)
  set (GIT_ASTROFORTRAN "git@github.com:jacopo-chevallard/astrofortran.git")
else (SHIPPABLE)
  set (GIT_ASTROFORTRAN "https://github.com/jacopo-chevallard/astrofortran.git")
endif(SHIPPABLE)

ExternalProject_Add(
  EXT_${ASTROFORTRAN_LIBRARY_NAME}
  DOWNLOAD_DIR ${ASTROFORTRAN_PREFIX}
  SOURCE_DIR ${ASTROFORTRAN_SOURCE}
  BINARY_DIR ${ASTROFORTRAN_BINARY}
  INSTALL_DIR ${ASTROFORTRAN_INSTALL}
  GIT_REPOSITORY ${GIT_ASTROFORTRAN}
  CMAKE_ARGS -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_NO_DEFAULT_PATH=${CMAKE_NO_DEFAULT_PATH} -DSHIPPABLE=${SHIPPABLE} -DCMAKE_PARENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR} -DCMAKE_LIBRARY_TYPE=${CMAKE_LIBRARY_TYPE}
  )

set ( ASTROFORTRAN_INCLUDE_DIR ${ASTROFORTRAN_CMAKE_INCLUDEDIR} CACHE INTERNAL "ASTROFORTRAN include directory" )
set ( ASTROFORTRAN_LIBRARIES "${ASTROFORTRAN_CMAKE_LIBDIR}/${CMAKE_LIBRARY_PREFIX}${ASTROFORTRAN_LIBRARY_NAME}${CMAKE_LIBRARY_SUFFIX}" CACHE INTERNAL "ASTROFORTRAN library" )

include(parseDependencies)
include(Dependencies_${ASTROFORTRAN_LIBRARY_NAME})
parseDependencies(DEPENDENCIES_LIST ${Dependencies_${ASTROFORTRAN_LIBRARY_NAME}})

foreach (dependency ${Dependencies_names_${ASTROFORTRAN_LIBRARY_NAME}})

  string(TOUPPER ${dependency} tmp)

  # If the library cannot be found, add the compilation instructions
  if (NOT ${tmp}_FOUND)

    if (NOT TARGET EXT_${dependency})
      include(external_${dependency})
      string(TOUPPER ${dependency} tmp)
      set(include_directories_list ${include_directories_list} "${${tmp}_INCLUDE_DIR}" CACHE INTERNAL "List of include directories")
      set(target_link_libraries_list ${target_link_libraries_list} "${${tmp}_LIBRARIES}"  CACHE INTERNAL "List of libraries to be linked")
    endif (NOT TARGET EXT_${dependency})

    add_dependencies (EXT_${ASTROFORTRAN_LIBRARY_NAME} EXT_${dependency})

  else (NOT ${tmp}_FOUND)

    set(include_directories_list ${include_directories_list} "${${tmp}_INCLUDE_DIR}" CACHE INTERNAL "List of include directories")
    set(target_link_libraries_list ${target_link_libraries_list} "${${tmp}_LIBRARIES}" CACHE INTERNAL "List of libraries to be linked")

  endif (NOT ${tmp}_FOUND)


endforeach(dependency)
