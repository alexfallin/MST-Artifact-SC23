OPT = -O3

TBB_INCLUDE_PATH = -I./oneTBB/include/
TBB_LIBRARY_PATH = -L./oneTBB/build/linux_intel64_gcc_cc11_libc2.33_kernel5.17.8_release

MGPU_INCLUDE_PATH= -I../../moderngpu_1.1/include 

NVCC = nvcc 
CC = g++ -fopenmp -ltbb 


WARNINGS = -Wall -Wextra
SUPPRESS_WARNINGS = -Wno-long-long -Wno-unused-value -Wno-unused-local-typedefs -Wno-sign-compare -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-function -Wno-reorder -Wno-strict-aliasing

NVCC_WARNINGS = -Wall,-Wextra
NVCC_SUPPRESS_WARNINGS = -Wno-long-long,-Wno-unused-value,-Wno-unused-local-typedefs,-Wno-sign-compare,-Wno-unused-but-set-variable,-Wno-unused-parameter,-Wno-unused-function,-Wno-reorder,-Wno-strict-aliasing





GENCODE_FLAGS = -gencode arch=compute_70,code=compute_70
NVCCFLAGS = $(OPT) -arch=sm_70 --compiler-options $(NVCC_WARNINGS)
NVCC_INCLUDES = -Iinclude/ $(MGPU_INCLUDE_PATH)
NVCC_LIBS = -Llib/

CFLAGS = $(OPT) $(WARNINGS) $(SUPPRESS_WARNINGS) -std=c++11 
LIBS =  -Llib/ $(TBB_LIBRARY_PATH) 
INCLUDE = -Iinclude/ $(TBB_INCLUDE_PATH)



#usage
apps: BoruvkaUMinho_OMP BoruvkaUMinho_GPU

BoruvkaUMinho_GPU: apps/boruvka_gpu/main.cu
	$(NVCC) $(NVCCFLAGS) $(NVCC_INCLUDES) $(NVCC_LIBS) -lBoruvkaUMinho_GPU $^ -o bin/$@

BoruvkaUMinho_OMP: apps/boruvka_omp/main.cpp
	$(CC) $(CFLAGS) $(INCLUDE) $(LIBS) -lBoruvkaUMinho_OMP $^ -o bin/$@


# compile lib
#

libs: libBoruvkaUMinho_OMP libBoruvkaUMinho_GPU

libBoruvkaUMinho_GPU: src/BoruvkaUMinho_GPU.cu include/BoruvkaUMinho_GPU.cuh
	$(NVCC) --compiler-options '-fPIC' -shared -o lib/libBoruvkaUMinho_GPU.so $(NVCCFLAGS) $(NVCC_INCLUDES) $(NVCC_LIBS)  src/BoruvkaUMinho_GPU.cu src/cu_CSR_Graph.cu ../../moderngpu_1.1/src/mgpucontext.cu ../../moderngpu_1.1/src/mgpuutil.cpp

libBoruvkaUMinho_OMP: src/BoruvkaUMinho_OMP.cpp include/BoruvkaUMinho_OMP.hpp
	$(CC) -fPIC -shared src/BoruvkaUMinho_OMP.cpp src/CSR_Graph.cpp -o lib/libBoruvkaUMinho_OMP.so $(CFLAGS) $(INCLUDE) $(LIBS)

%.o: %.cpp
	$(CC) $(CFLAGS) $(INCLUDE) $(LIBS) -c $^ -o $@
