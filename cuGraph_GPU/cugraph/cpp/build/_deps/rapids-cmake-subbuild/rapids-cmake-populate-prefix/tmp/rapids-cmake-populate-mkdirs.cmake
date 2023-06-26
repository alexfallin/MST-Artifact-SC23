# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-src"
  "/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-build"
  "/data/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-subbuild/rapids-cmake-populate-prefix"
  "/data/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-subbuild/rapids-cmake-populate-prefix/tmp"
  "/data/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-subbuild/rapids-cmake-populate-prefix/src/rapids-cmake-populate-stamp"
  "/data/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-subbuild/rapids-cmake-populate-prefix/src"
  "/data/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-subbuild/rapids-cmake-populate-prefix/src/rapids-cmake-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/data/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-subbuild/rapids-cmake-populate-prefix/src/rapids-cmake-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/data/home/alex/mst/cugraph/cpp/build/_deps/rapids-cmake-subbuild/rapids-cmake-populate-prefix/src/rapids-cmake-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
