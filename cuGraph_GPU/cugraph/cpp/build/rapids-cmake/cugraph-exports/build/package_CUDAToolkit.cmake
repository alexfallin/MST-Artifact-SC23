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
