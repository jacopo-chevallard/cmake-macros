function (parse_dependencies)

  # Parse arguments
  set(options )
  set(oneValueArgs DEPENDENCIES_NESTED)
  set(multiValueArgs DEPENDENCIES_LIST)

  cmake_parse_arguments(PARSE_DEPENDENCIES "${options}" "${oneValueArgs}"
                          "${multiValueArgs}" ${ARGN})

  foreach (dependency ${PARSE_DEPENDENCIES_DEPENDENCIES_LIST})

    # Parse element from above "dependency" list, converting each element into
    # a string, i.e. replacing all instances of "%" with ";" (which, in cmake,
    # separate the list elements)
    string(REPLACE "%" ";" dependency ${dependency})

    list(LENGTH dependency len)

    # Get each element from the list into different variables
    list(GET dependency 0 dependency_name)

    find_file(full_path_${dependency_name} NAMES Dependencies_${dependency_name}${SHIPPABLE_SUFFIX}.cmake PATHS "$ENV{CMAKE_MACROS}/external")
    if (full_path_${dependency_name})
      LIST (APPEND PARSE_DEPENDENCIES_DEPENDENCIES_NESTED ${dependency_name})
    endif()

  endforeach(dependency)

  set (${DEPENDENCIES_NESTED} ${PARSE_DEPENDENCIES_DEPENDENCIES_NESTED} PARENT_SCOPE)

endfunction()

function (find_dependencies)

  # Parse arguments
  set(options )
  set(multiValueArgs DEPENDENCIES_LIST)

  cmake_parse_arguments(PARSE_DEPENDENCIES "${options}" "${oneValueArgs}"
                          "${multiValueArgs}" ${ARGN})

  foreach (dependency ${PARSE_DEPENDENCIES_DEPENDENCIES_LIST})

    # Parse element from above "dependency" list, converting each element into
    # a string, i.e. replacing all instances of "%" with ";" (which, in cmake,
    # separate the list elements)
    string(REPLACE "%" ";" dependency ${dependency})

    list(LENGTH dependency len)

    # Get each element from the list into different variables
    list(GET dependency 0 dependency_name)

    string(TOUPPER ${dependency_name} tmp)

    MESSAGE(STATUS "")
    MESSAGE(STATUS "dependency_name: " ${dependency_name})

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

  endforeach(dependency)

endfunction()
