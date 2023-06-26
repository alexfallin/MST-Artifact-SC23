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
include tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/flags.make

tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o: tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/flags.make
tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o: tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/includes_CUDA.rsp
tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o: /home/alex/mst/cugraph/cpp/tests/centrality/legacy/betweenness_centrality_test.cu
tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o: tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o"
	cd /home/alex/mst/cugraph/cpp/build/tests && /usr/local/cuda/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -MD -MT tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o -MF CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o.d -x cu -c /home/alex/mst/cugraph/cpp/tests/centrality/legacy/betweenness_centrality_test.cu -o CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o

tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

# Object files for target LEGACY_BETWEENNESS_TEST
LEGACY_BETWEENNESS_TEST_OBJECTS = \
"CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o"

# External object files for target LEGACY_BETWEENNESS_TEST
LEGACY_BETWEENNESS_TEST_EXTERNAL_OBJECTS =

tests/LEGACY_BETWEENNESS_TEST: tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/centrality/legacy/betweenness_centrality_test.cu.o
tests/LEGACY_BETWEENNESS_TEST: tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/build.make
tests/LEGACY_BETWEENNESS_TEST: tests/libcugraphtestutil.a
tests/LEGACY_BETWEENNESS_TEST: libcugraph.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest_main.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libnccl.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcugraph-ops++.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libnvToolsExt.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libraft_distance.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcudart.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcurand.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusolver.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcusparse.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublas.so
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libcublasLt.so
tests/LEGACY_BETWEENNESS_TEST: /usr/local/cuda/lib64/libculibos.a
tests/LEGACY_BETWEENNESS_TEST: /home/waf13/anaconda3/envs/cugraph_dev/lib/libgtest.so
tests/LEGACY_BETWEENNESS_TEST: tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/alex/mst/cugraph/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable LEGACY_BETWEENNESS_TEST"
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/build: tests/LEGACY_BETWEENNESS_TEST
.PHONY : tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/build

tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/clean:
	cd /home/alex/mst/cugraph/cpp/build/tests && $(CMAKE_COMMAND) -P CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/clean

tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/depend:
	cd /home/alex/mst/cugraph/cpp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alex/mst/cugraph/cpp /home/alex/mst/cugraph/cpp/tests /home/alex/mst/cugraph/cpp/build /home/alex/mst/cugraph/cpp/build/tests /home/alex/mst/cugraph/cpp/build/tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/LEGACY_BETWEENNESS_TEST.dir/depend

