function ( parseDependencies )

  # Parse arguments

  foreach (i ${ARGN})
    if ("${i}" STREQUAL "DEPENDENCIES_LIST")
      set(argname dependencies_list)
    else()
      set(${argname} ${${argname}} ${i})
    endif()
  endforeach()

  foreach (dependency ${dependencies_list})

    # Parse element from above "dependency" list, converting each element into
    # a string, i.e. replacing all instances of "%" with ";" (which, in cmake,
    # separate the list elements)
    string(REPLACE "%" ";" dependency ${dependency})

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

    #MESSAGE(STATUS "")
    #MESSAGE(STATUS "dependency_name: " ${dependency_name})
    #MESSAGE(STATUS "${tmp}_FOUND: " ${${tmp}_FOUND})


    # If the library cannot be found, add the compilation instructions
    #if (NOT ${dependency_name}_FOUND)
    #  include(External_${dependency_name})
    #  add_dependencies (${PROGRAM_NAME} EXT_${dependency_name})
    #endif (NOT ${dependency_name}_FOUND)

    # Finally, add the current library to the list containinig the include
    # folder, libraries folder, and libraries name
    #set(include_directories_list ${include_directories_list} "${${dependency_name}_INCLUDE_DIR}")
    #set(target_link_libraries_list ${target_link_libraries_list} "${${dependency_name}_LIBRARIES}")

  endforeach(dependency)

endfunction()
