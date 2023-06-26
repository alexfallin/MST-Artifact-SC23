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
include tests/CMakeFiles/SSSP_TEST.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/SSSP_TEST.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/SSSP_TEST.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/SSSP_TEST.dir/flags.make

tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o: tests/CMakeFiles/SSSP_TEST.dir/flags.make
tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o: /home/alex/mst/cugraph/cpp/tests/traversal/sssp_test.cpp
tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o: tests/CMakeFiles/SSSP_TEST.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o"
	cd /home/alex/mst/cugraph/cpp/build/tests && /home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o -MF CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o.d -o CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o -c /home/alex/mst/cugraph/cpp/tests/traversal/sssp_test.cpp

tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.i"
	cd /home/alex/mst/cugraph/cpp/build/tests && /home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/alex/mst/cugraph/cpp/tests/traversal/sssp_test.cpp > CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.i

tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.s"
	cd /home/alex/mst/cugraph/cpp/build/tests && /home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/alex/mst/cugraph/cpp/tests/traversal/sssp_test.cpp -o CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.s

# Object files for target SSSP_TEST
SSSP_TEST_OBJECTS = \
"CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o"

# External object files for target SSSP_TEST
SSSP_TEST_EXTERNAL_OBJECTS =

tests/SSSP_TEST: tests/CMakeFiles/SSSP_TEST.dir/traversal/sssp_test.cpp.o
tests/SSSP_TEST: tests/CMakeFiles/SSSP_TEST.dir/build.make
tests/SSSP_TEST: tests/libcugraphtestutil.a
tests/SSSP_TEST: libcugraph.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest_main.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libnccl.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcugraph-ops++.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libnvToolsExt.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libraft_distance.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcudart.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcurand.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusolver.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusparse.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublas.so
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublasLt.so
tests/SSSP_TEST: /usr/local/cuda/lib64/libculibos.a
tests/SSSP_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest.so
tests/SSSP_TEST: tests/CMakeFiles/SSSP_TEST.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable SSSP_TEST"
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/SSSP_TEST.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/SSSP_TEST.dir/build: tests/SSSP_TEST
.PHONY : tests/CMakeFiles/SSSP_TEST.dir/build

tests/CMakeFiles/SSSP_TEST.dir/clean:
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -P CMakeFiles/SSSP_TEST.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/SSSP_TEST.dir/clean

tests/CMakeFiles/SSSP_TEST.dir/depend:
	cd /home/alex/mst/cugraph/cpp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alex/mst/cugraph/cpp /home/alex/mst/cugraph/cpp/tests /home/alex/mst/cugraph/cpp/build /home/alex/mst/cugraph/cpp/build/tests /home/alex/mst/cugraph/cpp/build/tests/CMakeFiles/SSSP_TEST.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/SSSP_TEST.dir/depend

