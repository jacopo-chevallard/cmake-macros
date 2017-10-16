include(getDependencyPath)

function (addNestedIncludeDirectories dependency_name include_directories_list)

  string(REPLACE "%" ";" dependency ${dependency_name})
  list(GET dependency 0 dependency_lib_name)


  #list(FIND target_link_libraries_list "${dependency_lib_name}" HasLibrary)
  #IF(HasLibrary GREATER -1)
  #  return()
  #ENDIF()

  # MESSAGE(STATUS "dependency_lib_name: ${dependency_lib_name}")

  include(Dependencies_${dependency_lib_name}${SHIPPABLE_SUFFIX} OPTIONAL RESULT_VARIABLE NESTED_DEPENDENCIES)

  if (NESTED_DEPENDENCIES)

    #set(target_link_libraries_local "${target_link_libraries_list}")
    set(include_directories_local "${include_directories_list}")

    foreach (sub_dependency ${Dependencies_${dependency_lib_name}})

      #MESSAGE(STATUS "target_link_libraries_list function: ${target_link_libraries_list}")
      string(REPLACE "%" ";" sub_dependency_name ${sub_dependency})
      list(GET sub_dependency_name 0 sub_dependency_lib_name)
      #MESSAGE(STATUS "dependency function: ${sub_dependency}")

      # Library name
      addNestedDependencies(${sub_dependency} "${target_link_libraries_local}" "${include_directories_local}")
      getDependencyPath(${sub_dependency})
      #set (LIB_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include/${dependency})
      #set (LIB_NAME "${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_LIBRARY_PREFIX}${dependency}${CMAKE_LIBRARY_SUFFIX}")

      string(TOUPPER ${sub_dependency_lib_name} tmp)
      set(include_directories_local ${include_directories_local} "${${tmp}_INCLUDE_DIR}")
      #set(target_link_libraries_local ${target_link_libraries_local} "${${tmp}_LIBRARIES}")

    endforeach(sub_dependency)

    set(include_directories_list ${include_directories_local} PARENT_SCOPE)
    #set(target_link_libraries_list ${target_link_libraries_local} PARENT_SCOPE)

  ENDif (NESTED_DEPENDENCIES)

endfunction()
