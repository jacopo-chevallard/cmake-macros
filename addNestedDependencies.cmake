include(getDependencyPath)

# -------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------
function (addNestedIncludeDirectories dependency_name include_directories_list)

  set(recursion FALSE)
  set (extra_macro_args ${ARGN})

  # Did we get any optional args?
  list(LENGTH extra_macro_args num_extra_args)
  if (${num_extra_args} GREATER 0)
    set(recursion TRUE)
  endif ()

  if (NOT recursion)
    set(include_directories_local "${include_directories_list}" CACHE INTERNAL "" )
  endif (NOT recursion)

  string(REPLACE "%" ";" dependency ${dependency_name})
  list(GET dependency 0 dependency_lib_name)

  include(Dependencies_${dependency_lib_name}${SHIPPABLE_SUFFIX} OPTIONAL RESULT_VARIABLE NESTED_DEPENDENCIES)

  if (NESTED_DEPENDENCIES)

    set(include_directories_local "${include_directories_list}")

    foreach (sub_dependency ${Dependencies_${dependency_lib_name}})

      string(REPLACE "%" ";" sub_dependency_name ${sub_dependency})
      list(GET sub_dependency_name 0 sub_dependency_lib_name)

      # Library name
      addNestedIncludeDirectories(${sub_dependency} "${include_directories_local}" TRUE)
      getDependencyPath(${sub_dependency})

      string(TOUPPER ${sub_dependency_lib_name} tmp)
      set(include_directories_local ${include_directories_local} "${${tmp}_INCLUDE_DIR}" CACHE INTERNAL "")

    endforeach(sub_dependency)

    set(include_directories_list ${include_directories_local} PARENT_SCOPE)

  ENDif (NESTED_DEPENDENCIES)

endfunction()


# -------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------
function (addNestedLibraries dependency_name target_link_libraries_list)

  set(recursion FALSE)
  set (extra_macro_args ${ARGN})

  # Did we get any optional args?
  list(LENGTH extra_macro_args num_extra_args)
  if (${num_extra_args} GREATER 0)
    set(recursion TRUE)
  endif ()

  if (NOT recursion)
    set(target_link_libraries_local "${target_link_libraries_list}" CACHE INTERNAL "" )
  endif (NOT recursion)

  MESSAGE(STATUS "dependency_name----------> " ${dependency_name})

  string(REPLACE "%" ";" dependency ${dependency_name})
  list(GET dependency 0 dependency_lib_name)

  MESSAGE(STATUS "dependency_lib_name----------> " ${dependency_lib_name})
  include(Dependencies_${dependency_lib_name}${SHIPPABLE_SUFFIX} OPTIONAL RESULT_VARIABLE NESTED_DEPENDENCIES)

  if (NESTED_DEPENDENCIES)

    foreach (sub_dependency ${Dependencies_${dependency_lib_name}})

      string(REPLACE "%" ";" sub_dependency_name ${sub_dependency})
      list(GET sub_dependency_name 0 sub_dependency_lib_name)

      # Library name
      addNestedLibraries(${sub_dependency} "${target_link_libraries_local}" TRUE)
      getDependencyPath(${sub_dependency})

      string(TOUPPER ${sub_dependency_lib_name} tmp)
      set(target_link_libraries_local ${target_link_libraries_local} "${${tmp}_LIBRARIES}" CACHE INTERNAL "" )

    endforeach(sub_dependency)

    set(target_link_libraries_list ${target_link_libraries_local} PARENT_SCOPE)

  ENDif (NESTED_DEPENDENCIES)

endfunction()
