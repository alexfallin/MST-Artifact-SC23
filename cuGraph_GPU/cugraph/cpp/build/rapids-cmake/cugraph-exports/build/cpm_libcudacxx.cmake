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
