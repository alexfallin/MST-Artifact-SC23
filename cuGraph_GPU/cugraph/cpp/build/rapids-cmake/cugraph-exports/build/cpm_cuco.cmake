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
