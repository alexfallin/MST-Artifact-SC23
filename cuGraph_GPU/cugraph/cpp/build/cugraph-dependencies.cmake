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

include(CMakeFindDependencyMacro)

#=============================================================================
# Copyright (c) 2021, NVIDIA CORPORATION.
#
# Licensed under the Apache License, Version 2.0 (the "License")
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
include_guard(GLOBAL)

#[=======================================================================[.rst:
rapids_cpm_download
-------------------

.. versionadded:: v21.10.00

Does the downloading of the `CPM` module

.. code-block:: cmake

  rapids_cpm_download()

The CPM module will be downloaded based on the state of :cmake:variable:`CPM_SOURCE_CACHE` and
:cmake:variable:`ENV{CPM_SOURCE_CACHE}`.

.. note::
  Use `rapids_cpm_init` instead of this function, as this is an implementation detail
  required for proper cpm project exporting in build directories

  This function can't call other rapids-cmake functions, due to the
  restrictions of `write_dependencies.cmake`

#]=======================================================================]
function(rapids_cpm_download)
  list(APPEND CMAKE_MESSAGE_CONTEXT "rapids.cpm.download")

  # When changing version verify no new variables needs to be propagated
  set(CPM_DOWNLOAD_VERSION 0.35.6)

  if(CPM_SOURCE_CACHE)
    # Expand relative path. This is important if the provided path contains a tilde (~)
    cmake_path(ABSOLUTE_PATH CPM_SOURCE_CACHE)

    # default to the same location that cpm computes
    set(CPM_DOWNLOAD_LOCATION "${CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
    if(EXISTS "${CPM_SOURCE_CACHE}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
      # Also support the rapids-cmake download location ( cmake/ vs cpm/ )
      set(CPM_DOWNLOAD_LOCATION "${CPM_SOURCE_CACHE}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
    endif()

  elseif(DEFINED ENV{CPM_SOURCE_CACHE})

    # default to the same location that cpm computes
    set(CPM_DOWNLOAD_LOCATION "$ENV{CPM_SOURCE_CACHE}/cpm/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
    if(EXISTS "$ENV{CPM_SOURCE_CACHE}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
      # Also support the rapids-cmake download location ( cmake/ vs cpm/ )
      set(CPM_DOWNLOAD_LOCATION "$ENV{CPM_SOURCE_CACHE}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
    endif()

  else()
    set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_DOWNLOAD_VERSION}.cmake")
  endif()

  if(NOT (EXISTS ${CPM_DOWNLOAD_LOCATION}))
    message(VERBOSE "Downloading CPM.cmake to ${CPM_DOWNLOAD_LOCATION}")
    file(DOWNLOAD
         https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake
         ${CPM_DOWNLOAD_LOCATION})
  endif()

  include(${CPM_DOWNLOAD_LOCATION})

  # Propagate up any modified local variables that CPM has changed.
  #
  # Push up the modified CMAKE_MODULE_PATh to allow `find_package` calls to find packages that CPM
  # already added.
  set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)

endfunction()
rapids_cpm_download()

# re-use our CPM source cache if not set
if(NOT DEFINED CPM_SOURCE_CACHE)
  set(CPM_SOURCE_CACHE "@CPM_SOURCE_CACHE@")
  set(rapids_clear_cpm_cache true)
endif()
#=============================================================================
# find_dependency Search for CUDAToolkit
#
# Make sure we search for a build-dir config module for the project
set(possible_package_dir "")
if(possible_package_dir AND NOT DEFINED CUDAToolkit_DIR)
  set(CUDAToolkit_DIR "${possible_package_dir}")
endif()

find_dependency(CUDAToolkit)

if(possible_package_dir)
  unset(possible_package_dir)
endif()
#=============================================================================

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


# CPM Search for libcudacxx
#
# Make sure we search for a build-dir config module for the CPM project
set(possible_package_dir "/home/waf13/anaconda3/envs/cugraph_dev/lib/cmake/libcudacxx")
if(possible_package_dir AND NOT DEFINED libcudacxx_DIR)
  set(libcudacxx_DIR "${possible_package_dir}")
endif()

CPMFindPackage(
  "NAME;libcudacxx;VERSION;1.8.1;GIT_REPOSITORY;https://github.com/NVIDIA/libcudacxx.git;GIT_TAG;1.8.1;GIT_SHALLOW;ON;PATCH_COMMAND;EXCLUDE_FROM_ALL;OFF"
  )

if(possible_package_dir)
  unset(possible_package_dir)
endif()
#=============================================================================

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


# CPM Search for cuco
#
# Make sure we search for a build-dir config module for the CPM project
set(possible_package_dir "/home/waf13/anaconda3/envs/cugraph_dev/lib/cmake/cuco")
if(possible_package_dir AND NOT DEFINED cuco_DIR)
  set(cuco_DIR "${possible_package_dir}")
endif()

CPMFindPackage(
  "NAME;cuco;VERSION;0.0.1;GIT_REPOSITORY;https://github.com/NVIDIA/cuCollections.git;GIT_TAG;2a194c9831324904120113bc18135e7933369ee8;GIT_SHALLOW;OFF;PATCH_COMMAND;EXCLUDE_FROM_ALL;ON;OPTIONS;BUILD_TESTS OFF;BUILD_BENCHMARKS OFF;BUILD_EXAMPLES OFF;INSTALL_CUCO OFF"
  )

if(possible_package_dir)
  unset(possible_package_dir)
endif()
#=============================================================================

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


# CPM Search for raft
#
# Make sure we search for a build-dir config module for the CPM project
set(possible_package_dir "/home/waf13/anaconda3/envs/cugraph_dev/lib/cmake/raft")
if(possible_package_dir AND NOT DEFINED raft_DIR)
  set(raft_DIR "${possible_package_dir}")
endif()

CPMFindPackage(
  "NAME;raft;VERSION;23.02.00;EXCLUDE_FROM_ALL;TRUE;GIT_REPOSITORY;https://github.com/rapidsai/raft.git;GIT_TAG;branch-23.02;SOURCE_SUBDIR;cpp;FIND_PACKAGE_ARGUMENTS;COMPONENTS distance;OPTIONS;RAFT_COMPILE_LIBRARIES OFF;RAFT_COMPILE_DIST_LIBRARY ON;BUILD_TESTS OFF;BUILD_BENCH OFF;RAFT_ENABLE_cuco_DEPENDENCY OFF"
  )

if(possible_package_dir)
  unset(possible_package_dir)
endif()
#=============================================================================

#=============================================================================
# find_dependency Search for cugraph-ops
#
# Make sure we search for a build-dir config module for the project
set(possible_package_dir "/home/waf13/anaconda3/envs/cugraph_dev/lib/cmake/cugraph-ops")
if(possible_package_dir AND NOT DEFINED cugraph-ops_DIR)
  set(cugraph-ops_DIR "${possible_package_dir}")
endif()

find_package(cugraph-ops 23.02.00 QUIET)
find_dependency(cugraph-ops)

if(possible_package_dir)
  unset(possible_package_dir)
endif()
#=============================================================================


set(rapids_global_targets libcudacxx::libcudacxx;cuco::cuco;raft::raft;cugraph-ops::cugraph-ops++)


foreach(target IN LISTS rapids_global_targets)
  if(TARGET ${target})
    get_target_property(_is_imported ${target} IMPORTED)
    get_target_property(_already_global ${target} IMPORTED_GLOBAL)
    if(_is_imported AND NOT _already_global)
        set_target_properties(${target} PROPERTIES IMPORTED_GLOBAL TRUE)
    endif()
  endif()
endforeach()

unset(rapids_global_targets)
unset(rapids_clear_cpm_cache)
