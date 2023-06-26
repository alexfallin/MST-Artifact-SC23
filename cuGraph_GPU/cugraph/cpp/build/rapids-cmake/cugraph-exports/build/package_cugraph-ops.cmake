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
