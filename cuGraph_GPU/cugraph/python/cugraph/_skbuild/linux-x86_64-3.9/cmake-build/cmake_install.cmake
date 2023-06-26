# Install script for directory: /data/home/alex/mst/cugraph/python/cugraph

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/_deps/rapids-cmake-build/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/centrality/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/community/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/components/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/dask/comms/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/dask/structure/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/generators/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/internals/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/layout/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/linear_assignment/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/link_prediction/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/structure/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/tree/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/cugraph/utilities/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/data/home/alex/mst/cugraph/python/cugraph/_skbuild/linux-x86_64-3.9/cmake-build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
