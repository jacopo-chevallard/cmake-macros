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

  string(REPLACE "%" ";" dependency ${dependency_name})
  list(GET dependency 0 dependency_lib_name)

  #MESSAGE("dependency_lib_name: ${dependency_lib_name} ${recursion}")

  if (NOT recursion)
    set(include_directories_local "${include_directories_list}" CACHE INTERNAL "" )
  endif (NOT recursion)

  string(TOUPPER ${dependency_lib_name} tmp)
  #getDependencyPath(${dependency_name})
  #MESSAGE("------------> ${${tmp}_INCLUDE_DIR}")
  set(include_directories_local ${include_directories_local} "${${tmp}_INCLUDE_DIR}" CACHE INTERNAL "" )

  #MESSAGE("include_directories_local: ${include_directories_local}")

  #include(Dependencies_${dependency_lib_name}${SHIPPABLE_SUFFIX} OPTIONAL RESULT_VARIABLE NESTED_DEPENDENCIES)

  #if (NESTED_DEPENDENCIES)

  #  foreach (sub_dependency ${Dependencies_${dependency_lib_name}})

      # Library name
      #   addNestedIncludeDirectories(${sub_dependency} "${include_directories_local}" TRUE)

      #  endforeach(sub_dependency)

      #ENDif (NESTED_DEPENDENCIES)

  set(include_directories_list ${include_directories_local} PARENT_SCOPE)

endfunction()


# -------------------------------------------------------------------------------
# 
# -------------------------------------------------------------------------------
function (addNestedLibraries dependency_name target_link_libraries_list)

  set(recursion FALSE)
  set (extra_macro_args ${ARGN})

  #MESSAGE("")
  # Did we get any optional args?
  list(LENGTH extra_macro_args num_extra_args)
  if (${num_extra_args} GREATER 0)
    set(recursion TRUE)
  endif ()

  string(REPLACE "%" ";" dependency ${dependency_name})
  list(GET dependency 0 dependency_lib_name)

  #MESSAGE("dependency_lib_name: ${dependency_lib_name} ${recursion}")

  if (NOT recursion)
    set(target_link_libraries_local "${target_link_libraries_list}" CACHE INTERNAL "" )
  endif (NOT recursion)


  string(TOUPPER ${dependency_lib_name} tmp)
  #getDependencyPath(${dependency_lib_name})
  set(target_link_libraries_local ${target_link_libraries_local} "${${tmp}_LIBRARIES}" CACHE INTERNAL "" )

  #MESSAGE("target_link_libraries_local: ${target_link_libraries_local}")

  #include(Dependencies_${dependency_lib_name}${SHIPPABLE_SUFFIX} OPTIONAL RESULT_VARIABLE NESTED_DEPENDENCIES)

  #if (NESTED_DEPENDENCIES)

  #  foreach (sub_dependency ${Dependencies_${dependency_lib_name}})

      # Library name
      #    addNestedLibraries(${sub_dependency} "${target_link_libraries_local}" TRUE)

      #string(TOUPPER ${sub_dependency_lib_name} tmp)
      #set(target_link_libraries_local ${target_link_libraries_local} "${${tmp}_LIBRARIES}" CACHE INTERNAL "" )

      #   endforeach(sub_dependency)

      # endif (NESTED_DEPENDENCIES)


  set(target_link_libraries_list ${target_link_libraries_local} PARENT_SCOPE)

endfunction()
