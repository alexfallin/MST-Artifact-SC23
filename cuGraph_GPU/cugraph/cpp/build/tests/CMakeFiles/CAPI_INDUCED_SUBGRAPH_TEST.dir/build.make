# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/waf13/anaconda3/envs/cugraph_dev/bin/cmake

# The command to remove a file.
RM = /home/waf13/anaconda3/envs/cugraph_dev/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/alex/mst/cugraph/cpp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/alex/mst/cugraph/cpp/build

# Include any dependencies generated for this target.
include tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/flags.make

tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o: tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/flags.make
tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o: /home/alex/mst/cugraph/cpp/tests/c_api/induced_subgraph_test.c
tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o: tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o"
	cd /home/alex/mst/cugraph/cpp/build/tests && /home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o -MF CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o.d -o CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o -c /home/alex/mst/cugraph/cpp/tests/c_api/induced_subgraph_test.c

tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.i"
	cd /home/alex/mst/cugraph/cpp/build/tests && /home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/alex/mst/cugraph/cpp/tests/c_api/induced_subgraph_test.c > CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.i

tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.s"
	cd /home/alex/mst/cugraph/cpp/build/tests && /home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/alex/mst/cugraph/cpp/tests/c_api/induced_subgraph_test.c -o CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.s

# Object files for target CAPI_INDUCED_SUBGRAPH_TEST
CAPI_INDUCED_SUBGRAPH_TEST_OBJECTS = \
"CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o"

# External object files for target CAPI_INDUCED_SUBGRAPH_TEST
CAPI_INDUCED_SUBGRAPH_TEST_EXTERNAL_OBJECTS =

tests/CAPI_INDUCED_SUBGRAPH_TEST: tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/c_api/induced_subgraph_test.c.o
tests/CAPI_INDUCED_SUBGRAPH_TEST: tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/build.make
tests/CAPI_INDUCED_SUBGRAPH_TEST: libcugraph_c.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: tests/libcugraph_c_testutil.a
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest_main.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: libcugraph.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libraft_distance.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcugraph-ops++.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcurand.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusolver.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusparse.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublas.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublasLt.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /usr/local/cuda/lib64/libculibos.a
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcudart.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libnvToolsExt.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest.so
tests/CAPI_INDUCED_SUBGRAPH_TEST: tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable CAPI_INDUCED_SUBGRAPH_TEST"
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/build: tests/CAPI_INDUCED_SUBGRAPH_TEST
.PHONY : tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/build

tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/clean:
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -P CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/clean

tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/depend:
	cd /home/alex/mst/cugraph/cpp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alex/mst/cugraph/cpp /home/alex/mst/cugraph/cpp/tests /home/alex/mst/cugraph/cpp/build /home/alex/mst/cugraph/cpp/build/tests /home/alex/mst/cugraph/cpp/build/tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/CAPI_INDUCED_SUBGRAPH_TEST.dir/depend

