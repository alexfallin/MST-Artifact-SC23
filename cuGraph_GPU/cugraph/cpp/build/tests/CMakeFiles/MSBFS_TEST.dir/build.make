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
include tests/CMakeFiles/MSBFS_TEST.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/MSBFS_TEST.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/MSBFS_TEST.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/MSBFS_TEST.dir/flags.make

tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o: tests/CMakeFiles/MSBFS_TEST.dir/flags.make
tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o: tests/CMakeFiles/MSBFS_TEST.dir/includes_CUDA.rsp
tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o: /home/alex/mst/cugraph/cpp/tests/traversal/ms_bfs_test.cu
tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o: tests/CMakeFiles/MSBFS_TEST.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o"
	cd /home/alex/mst/cugraph/cpp/build/tests && /usr/local/cuda/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -MD -MT tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o -MF CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o.d -x cu -c /home/alex/mst/cugraph/cpp/tests/traversal/ms_bfs_test.cu -o CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o

tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

# Object files for target MSBFS_TEST
MSBFS_TEST_OBJECTS = \
"CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o"

# External object files for target MSBFS_TEST
MSBFS_TEST_EXTERNAL_OBJECTS =

tests/MSBFS_TEST: tests/CMakeFiles/MSBFS_TEST.dir/traversal/ms_bfs_test.cu.o
tests/MSBFS_TEST: tests/CMakeFiles/MSBFS_TEST.dir/build.make
tests/MSBFS_TEST: tests/libcugraphtestutil.a
tests/MSBFS_TEST: libcugraph.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest_main.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libnccl.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcugraph-ops++.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libnvToolsExt.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libraft_distance.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcudart.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcurand.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusolver.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusparse.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublas.so
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublasLt.so
tests/MSBFS_TEST: /usr/local/cuda/lib64/libculibos.a
tests/MSBFS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest.so
tests/MSBFS_TEST: tests/CMakeFiles/MSBFS_TEST.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable MSBFS_TEST"
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/MSBFS_TEST.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/MSBFS_TEST.dir/build: tests/MSBFS_TEST
.PHONY : tests/CMakeFiles/MSBFS_TEST.dir/build

tests/CMakeFiles/MSBFS_TEST.dir/clean:
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -P CMakeFiles/MSBFS_TEST.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/MSBFS_TEST.dir/clean

tests/CMakeFiles/MSBFS_TEST.dir/depend:
	cd /home/alex/mst/cugraph/cpp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alex/mst/cugraph/cpp /home/alex/mst/cugraph/cpp/tests /home/alex/mst/cugraph/cpp/build /home/alex/mst/cugraph/cpp/build/tests /home/alex/mst/cugraph/cpp/build/tests/CMakeFiles/MSBFS_TEST.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/MSBFS_TEST.dir/depend

