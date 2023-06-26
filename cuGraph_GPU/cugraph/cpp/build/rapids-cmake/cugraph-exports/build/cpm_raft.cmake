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
