set(CMAKE_CUDA_COMPILER "/usr/local/cuda/bin/nvcc")
set(CMAKE_CUDA_HOST_COMPILER "")
set(CMAKE_CUDA_HOST_LINK_LAUNCHER "/home/waf13/anaconda3/envs/cugraph_dev/bin/g++")
set(CMAKE_CUDA_COMPILER_ID "NVIDIA")
set(CMAKE_CUDA_COMPILER_VERSION "11.6.112")
set(CMAKE_CUDA_DEVICE_LINKER "/usr/local/cuda/bin/nvlink")
set(CMAKE_CUDA_FATBINARY "/usr/local/cuda/bin/fatbinary")
set(CMAKE_CUDA_STANDARD_COMPUTED_DEFAULT "14")
set(CMAKE_CUDA_EXTENSIONS_COMPUTED_DEFAULT "ON")
set(CMAKE_CUDA_COMPILE_FEATURES "cuda_std_03;cuda_std_11;cuda_std_14;cuda_std_17")
set(CMAKE_CUDA03_COMPILE_FEATURES "cuda_std_03")
set(CMAKE_CUDA11_COMPILE_FEATURES "cuda_std_11")
set(CMAKE_CUDA14_COMPILE_FEATURES "cuda_std_14")
set(CMAKE_CUDA17_COMPILE_FEATURES "cuda_std_17")
set(CMAKE_CUDA20_COMPILE_FEATURES "")
set(CMAKE_CUDA23_COMPILE_FEATURES "")

set(CMAKE_CUDA_PLATFORM_ID "Linux")
set(CMAKE_CUDA_SIMULATE_ID "GNU")
set(CMAKE_CUDA_COMPILER_FRONTEND_VARIANT "")
set(CMAKE_CUDA_SIMULATE_VERSION "10.4")



set(CMAKE_CUDA_COMPILER_ENV_VAR "CUDACXX")
set(CMAKE_CUDA_HOST_COMPILER_ENV_VAR "CUDAHOSTCXX")

set(CMAKE_CUDA_COMPILER_LOADED 1)
set(CMAKE_CUDA_COMPILER_ID_RUN 1)
set(CMAKE_CUDA_SOURCE_FILE_EXTENSIONS cu)
set(CMAKE_CUDA_LINKER_PREFERENCE 15)
set(CMAKE_CUDA_LINKER_PREFERENCE_PROPAGATES 1)

set(CMAKE_CUDA_SIZEOF_DATA_PTR "8")
set(CMAKE_CUDA_COMPILER_ABI "ELF")
set(CMAKE_CUDA_BYTE_ORDER "LITTLE_ENDIAN")
set(CMAKE_CUDA_LIBRARY_ARCHITECTURE "")

if(CMAKE_CUDA_SIZEOF_DATA_PTR)
  set(CMAKE_SIZEOF_VOID_P "${CMAKE_CUDA_SIZEOF_DATA_PTR}")
endif()

if(CMAKE_CUDA_COMPILER_ABI)
  set(CMAKE_INTERNAL_PLATFORM_ABI "${CMAKE_CUDA_COMPILER_ABI}")
endif()

if(CMAKE_CUDA_LIBRARY_ARCHITECTURE)
  set(CMAKE_LIBRARY_ARCHITECTURE "")
endif()

set(CMAKE_CUDA_COMPILER_TOOLKIT_ROOT "/usr/local/cuda")
set(CMAKE_CUDA_COMPILER_TOOLKIT_LIBRARY_ROOT "/usr/local/cuda")
set(CMAKE_CUDA_COMPILER_TOOLKIT_VERSION "11.6.112")
set(CMAKE_CUDA_COMPILER_LIBRARY_ROOT "/usr/local/cuda")

set(CMAKE_CUDA_ARCHITECTURES_ALL "35-real;37-real;50-real;52-real;53-real;60-real;61-real;62-real;70-real;72-real;75-real;80-real;86-real;87")
set(CMAKE_CUDA_ARCHITECTURES_ALL_MAJOR "35-real;50-real;60-real;70-real;80")
set(CMAKE_CUDA_ARCHITECTURES_NATIVE "86-real")

set(CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES "/usr/local/cuda/targets/x86_64-linux/include")

set(CMAKE_CUDA_HOST_IMPLICIT_LINK_LIBRARIES "")
set(CMAKE_CUDA_HOST_IMPLICIT_LINK_DIRECTORIES "/usr/local/cuda/targets/x86_64-linux/lib/stubs;/usr/local/cuda/targets/x86_64-linux/lib")
set(CMAKE_CUDA_HOST_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

set(CMAKE_CUDA_IMPLICIT_INCLUDE_DIRECTORIES "/home/waf13/anaconda3/envs/cugraph_dev/lib/gcc/x86_64-conda-linux-gnu/10.4.0/include;/home/waf13/anaconda3/envs/cugraph_dev/lib/gcc/x86_64-conda-linux-gnu/10.4.0/include-fixed;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/include;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/include/c++/10.4.0;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/include/c++/10.4.0/x86_64-conda-linux-gnu;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/include/c++/10.4.0/backward;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/sysroot/usr/include")
set(CMAKE_CUDA_IMPLICIT_LINK_LIBRARIES "stdc++;m;gcc_s;gcc;c;gcc_s;gcc")
set(CMAKE_CUDA_IMPLICIT_LINK_DIRECTORIES "/home/waf13/anaconda3/envs/cugraph_dev/lib;/usr/local/cuda/targets/x86_64-linux/lib/stubs;/usr/local/cuda/targets/x86_64-linux/lib;/home/waf13/anaconda3/envs/cugraph_dev/lib/gcc/x86_64-conda-linux-gnu/10.4.0;/home/waf13/anaconda3/envs/cugraph_dev/lib/gcc;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/lib;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/sysroot/lib;/home/waf13/anaconda3/envs/cugraph_dev/x86_64-conda-linux-gnu/sysroot/usr/lib")
set(CMAKE_CUDA_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

set(CMAKE_CUDA_RUNTIME_LIBRARY_DEFAULT "STATIC")

set(CMAKE_LINKER "/home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-ld")
set(CMAKE_AR "/home/waf13/anaconda3/envs/cugraph_dev/bin/x86_64-conda-linux-gnu-ar")
set(CMAKE_MT "")
