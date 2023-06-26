#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "cugraph::cugraph" for configuration "Release"
set_property(TARGET cugraph::cugraph APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(cugraph::cugraph PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libcugraph.so"
  IMPORTED_SONAME_RELEASE "libcugraph.so"
  )

list(APPEND _cmake_import_check_targets cugraph::cugraph )
list(APPEND _cmake_import_check_files_for_cugraph::cugraph "${_IMPORT_PREFIX}/lib/libcugraph.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
