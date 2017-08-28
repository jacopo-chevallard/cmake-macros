function (getDependencyPath dependency_name)

  string(REPLACE "%" ";" dependency ${dependency_name})

  list(LENGTH dependency len)

  # Get each element from the list into different variables
  list(GET dependency 0 dependency_name)

  string(TOUPPER ${dependency_name} tmp)

  # Try to find the above libraries
  if (${len} STREQUAL "1")
    libfind_detect (${tmp} 
      FIND_LIBRARY ${dependency_name} LIBRARY_DIRS ${CMAKE_INSTALL_PREFIX}/lib 
      NO_DEFAULT_PATH ${CMAKE_NO_DEFAULT_PATH})
  elseif (${len} STREQUAL "2")
    list(GET dependency 1 dependency_header)
    libfind_detect (${tmp} 
      FIND_PATH ${dependency_header} INCLUDE_DIRS ${CMAKE_INSTALL_PREFIX}/include/${dependency_name} 
      FIND_LIBRARY ${dependency_name} LIBRARY_DIRS ${CMAKE_INSTALL_PREFIX}/lib 
      NO_DEFAULT_PATH ${CMAKE_NO_DEFAULT_PATH})
  endif (${len} STREQUAL "1")

  if (NOT ${tmp}_FOUND)
    include(external_${dependency_name})
  endif (NOT ${tmp}_FOUND)

endfunction()
