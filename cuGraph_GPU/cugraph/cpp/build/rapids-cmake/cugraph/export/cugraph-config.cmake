#=============================================================================
# Copyright (c) 2021, NVIDIA CORPORATION.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#=============================================================================

#[=======================================================================[

Provide targets for cuGraph.

cuGraph library is a collection of GPU accelerated graph algorithms that process data found in
[GPU DataFrames](https://github.com/rapidsai/cudf).



Result Variables
^^^^^^^^^^^^^^^^

This module will set the following variables::

  CUGRAPH_FOUND
  CUGRAPH_VERSION
  CUGRAPH_VERSION_MAJOR
  CUGRAPH_VERSION_MINOR

#]=======================================================================]


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

cmake_minimum_required(VERSION 3.23.1)

set(rapids_global_languages )
foreach(lang IN LISTS rapids_global_languages)
  include("${CMAKE_CURRENT_LIST_DIR}/cugraph-${lang}-language.cmake")
endforeach()
unset(rapids_global_languages)

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/cugraph-dependencies.cmake")
  include("${CMAKE_CURRENT_LIST_DIR}/cugraph-dependencies.cmake")
endif()

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/cugraph-targets.cmake")
  include("${CMAKE_CURRENT_LIST_DIR}/cugraph-targets.cmake")
endif()

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/cugraph-config-version.cmake")
  include("${CMAKE_CURRENT_LIST_DIR}/cugraph-config-version.cmake")
endif()

# Set our version variables
set(CUGRAPH_VERSION_MAJOR 23)
set(CUGRAPH_VERSION_MINOR 02)
set(CUGRAPH_VERSION_PATCH 00)
set(CUGRAPH_VERSION 23.02.00)


set(rapids_global_targets cugraph;cugraph_c)
set(rapids_namespaced_global_targets cugraph;cugraph_c)
if(rapids_namespaced_global_targets)
  list(TRANSFORM rapids_namespaced_global_targets PREPEND cugraph:: )
endif()

foreach(target IN LISTS rapids_namespaced_global_targets)
  if(TARGET ${target})
    get_target_property(_is_imported ${target} IMPORTED)
    get_target_property(_already_global ${target} IMPORTED_GLOBAL)
    if(_is_imported AND NOT _already_global)
      set_target_properties(${target} PROPERTIES IMPORTED_GLOBAL TRUE)
    endif()
  endif()
endforeach()

# For backwards compat
if("rapids_config_install" STREQUAL "rapids_config_build")
  foreach(target IN LISTS rapids_global_targets)
    if(TARGET ${target})
      get_target_property(_is_imported ${target} IMPORTED)
      get_target_property(_already_global ${target} IMPORTED_GLOBAL)
      if(_is_imported AND NOT _already_global)
        set_target_properties(${target} PROPERTIES IMPORTED_GLOBAL TRUE)
      endif()
      if(NOT TARGET cugraph::${target})
        add_library(cugraph::${target} ALIAS ${target})
      endif()
    endif()
  endforeach()
endif()

unset(rapids_global_targets)
unset(rapids_namespaced_global_targets)

check_required_components(cugraph)

set(${CMAKE_FIND_PACKAGE_NAME}_CONFIG "${CMAKE_CURRENT_LIST_FILE}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${CMAKE_FIND_PACKAGE_NAME} CONFIG_MODE)


