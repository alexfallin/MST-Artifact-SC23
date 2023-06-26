# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# compile CUDA with /usr/local/cuda/bin/nvcc
CUDA_DEFINES = -DCUDA_API_PER_THREAD_DEFAULT_STREAM -DCUTLASS_NAMESPACE=raft_cutlass -DGTEST_LINKED_AS_SHARED_LIBRARY=1 -DRAFT_DISTANCE_COMPILED -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_CUDA -DTHRUST_HOST_SYSTEM=THRUST_HOST_SYSTEM_CPP

CUDA_INCLUDES = --options-file CMakeFiles/CONNECT_TEST.dir/includes_CUDA.rsp

CUDA_FLAGS = -O3 -DNDEBUG --generate-code=arch=compute_60,code=[sm_60] --generate-code=arch=compute_70,code=[sm_70] --generate-code=arch=compute_75,code=[sm_75] --generate-code=arch=compute_80,code=[sm_80] --generate-code=arch=compute_86,code=[compute_86,sm_86] -Xcompiler=-fPIE --expt-extended-lambda --expt-relaxed-constexpr -Werror=cross-execution-space-call -Wno-deprecated-declarations -Xptxas=--disable-warnings -Xcompiler=-Wall,-Wno-error=sign-compare,-Wno-error=unused-but-set-variable -Xfatbin=-compress-all -std=c++17

