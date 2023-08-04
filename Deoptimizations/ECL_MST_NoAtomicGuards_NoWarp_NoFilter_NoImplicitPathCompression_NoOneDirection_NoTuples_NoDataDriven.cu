/*
ECL-MST: This code computes the minimum spanning forest of a given input graph.
 
Copyright (c) 2023, Alex Fallin and Martin Burtscher
 
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
 
1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
URL: The latest version of this code is available at https://cs.txstate.edu/~burtscher/research/ECL-MST/.
 
Publication: This work is described in detail in the following paper.
Alex Fallin, Andres Gonzales, Jarim Seo, Randy Cornell, and Martin Burtscher. "A High-Performance MST Implementation for GPUs." Proceedings of the 2023 ACM/IEEE International Conference for High Performance Computing, Networking, Storage, and Analysis. November 2023.
*/


#include <climits>
#include <algorithm>
#include <tuple>
#include <vector>
#include <sys/time.h>
#include <cuda.h>
#include "ECLgraph.h"

static const int Device = 0;
static const int ThreadsPerBlock = 512;
static const int RUNS = 9;

typedef unsigned long long ull;

static inline int serial_find(const int idx, int* const parent)
{
  int curr = parent[idx];
  if (curr != idx) {
    int next, prev = idx;
    while (curr != (next = parent[curr])) {
      parent[prev] = next;
      prev = curr;
      curr = next;
    }
  }
  return curr;
}

static inline void serial_join(const int a, const int b, int* const parent)
{
  const int arep = serial_find(a, parent);
  const int brep = serial_find(b, parent);
  if (arep > brep) {  // improves locality
    parent[brep] = arep;
  } else {
    parent[arep] = brep;
  }
}

static bool* cpuMST(const ECLgraph& g)
{
  bool* const inMST = new bool [g.edges];
  int* const parent = new int [g.nodes];

  timeval start, end;
  gettimeofday(&start, NULL);

  std::fill(inMST, inMST + g.edges, false);
  for (int i = 0; i < g.nodes; i++) parent[i] = i;

  std::vector<std::tuple<int, int, int, int>> list;  // <weight, edge index, from node, to node>
  for (int i = 0; i < g.nodes; i++) {
    for (int j = g.nindex[i]; j < g.nindex[i + 1]; j++) {
      const int n = g.nlist[j];
      if (n > i) {  // only one direction
        list.push_back(std::make_tuple(g.eweight[j], j, i, n));
      }
    }
  }
  std::sort(list.begin(), list.end());

  int count = g.nodes - 1;
  for (int pos = 0; pos < list.size(); pos++) {
    const int a = std::get<2>(list[pos]);
    const int b = std::get<3>(list[pos]);
    const int arep = serial_find(a, parent);
    const int brep = serial_find(b, parent);
    if (arep != brep) {
      const int j = std::get<1>(list[pos]);
      inMST[j] = true;
      serial_join(arep, brep, parent);
      count--;
      if (count == 0) break;
    }
  }

  gettimeofday(&end, NULL);
//  printf("Host: %12.9f s\n", end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0);

  delete [] parent;
  return inMST;
}

static inline __device__ int find(const int idx, volatile int* const __restrict__ parent) {
  int curr = parent[idx];
  if (curr != idx) {
    int next, prev = idx;
    while (curr != (next = parent[curr])) {
      parent[prev] = next;
      prev = curr;
      curr = next;
    }
  }
  return curr;
}

static inline __device__ void join(int arep, int brep, int* const __restrict__ parent)
{
  int mrep;
  do {
    mrep = max(arep, brep);
    arep = min(arep, brep);
  } while ((brep = atomicCAS(&parent[mrep], mrep, arep)) != mrep);
}

static __global__ void initPM(const int nodes, int* const __restrict__ parent, ull* const __restrict__ minv)
{
  const int v = threadIdx.x + blockIdx.x * ThreadsPerBlock;
  if (v < nodes) {
    parent[v] = v;
    minv[v] = ULONG_MAX;
  }
}

template <bool first>
static __global__ void initWL(const int nodes, const int* const __restrict__ nindex, int* const __restrict__ slist, const int* const __restrict__ nlist, const int* const __restrict__ eweight, ull* const __restrict__ minv, int* const __restrict__ parent, const int threshold)
{
  const int v = threadIdx.x + blockIdx.x * ThreadsPerBlock;
  int beg, end;
  if (v < nodes) {
    beg = nindex[v];
    end = nindex[v + 1];
    for (int j = beg; j < end; j++) {
      slist[j] = v;
    }
  }
}

static __global__ void kernel1(const int wl1size, bool* const __restrict__ go_again, int* const __restrict__ parent, ull* const __restrict__ minv, const int* const __restrict__ slist, const int* const __restrict__ nlist, const int* const __restrict__ eweight)
{
  const int j = threadIdx.x + blockIdx.x * ThreadsPerBlock;
  if (j < wl1size) {
    const int arep = find(slist[j], parent);
    const int brep = find(nlist[j], parent);
    if (arep != brep) {
      *go_again = true;
      const ull val = (((ull)eweight[j]) << 32) | j;
      atomicMin(&minv[arep], val);
      atomicMin(&minv[brep], val);
    }
  }
}

static __global__ void kernel2(const int wlsize, int* const __restrict__ parent, ull* const __restrict__ minv, bool* const __restrict__ inMST, const int* const __restrict__ slist, const int* const __restrict__ nlist, const int* const __restrict__ eweight)
{
  const int j = threadIdx.x + blockIdx.x * ThreadsPerBlock;
  if (j < wlsize) {
    const int arep = find(slist[j], parent);
    const int brep = find(nlist[j], parent);
    if (arep != brep) {
      const ull val = (((ull)eweight[j]) << 32) | j;
      if ((val == minv[arep]) || (val == minv[brep])) {
        join(arep, brep, parent);
        inMST[j] = true;
      }
    }
  }
}

static __global__ void kernel3(const int wlsize, int* const __restrict__ parent, volatile ull* const __restrict__ minv, const int* const __restrict__ slist, const int* const __restrict__ nlist)
{
  const int j = threadIdx.x + blockIdx.x * ThreadsPerBlock;
  if (j < wlsize) {
    const int arep = find(slist[j], parent);
    const int brep = find(nlist[j], parent);
    if (arep != brep) {
      minv[arep] = ULONG_MAX;
      minv[brep] = ULONG_MAX;
    }
  }
}

static void CheckCuda(const int line)
{
  cudaError_t e;
  cudaDeviceSynchronize();
  if (cudaSuccess != (e = cudaGetLastError())) {
    fprintf(stderr, "CUDA error %d on line %d: %s\n", e, line, cudaGetErrorString(e));
    exit(-1);
  }
}

template <bool filter>
static bool* gpuMST(const ECLgraph& g, const int threshold)
{
  bool* d_inMST = NULL;
  cudaMalloc((void**)&d_inMST, g.edges * sizeof(bool));
  bool* const inMST = new bool [g.edges];

  int* d_parent = NULL;
  cudaMalloc((void**)&d_parent, g.nodes * sizeof(int));

  ull* d_minv = NULL;
  cudaMalloc((void**)&d_minv, g.nodes * sizeof(ull));

  bool* d_go_again = NULL;
  cudaMalloc((void**)&d_go_again, sizeof(bool));

  int* d_nindex = NULL;
  cudaMalloc((void**)&d_nindex, (g.nodes + 1) * sizeof(int));
  cudaMemcpy(d_nindex, g.nindex, (g.nodes + 1) * sizeof(int), cudaMemcpyHostToDevice);

  int* d_nlist = NULL;
  cudaMalloc((void**)&d_nlist, g.edges * sizeof(int));
  cudaMemcpy(d_nlist, g.nlist, g.edges * sizeof(int), cudaMemcpyHostToDevice);

  int* d_slist = NULL;
  cudaMalloc((void**)&d_slist, g.edges * sizeof(int));

  int* d_eweight = NULL;
  cudaMalloc((void**)&d_eweight, g.edges * sizeof(int));
  cudaMemcpy(d_eweight, g.eweight, g.edges * sizeof(int), cudaMemcpyHostToDevice);

  CheckCuda(__LINE__);

  timeval start, end;
  gettimeofday(&start, NULL);

  int blocks = (g.nodes + ThreadsPerBlock - 1) / ThreadsPerBlock;
  initPM<<<blocks, ThreadsPerBlock>>>(g.nodes, d_parent, d_minv);
  cudaMemset(d_inMST, 0, g.edges * sizeof(bool));

  initWL<true><<<blocks, ThreadsPerBlock>>>(g.nodes, d_nindex, d_slist, d_nlist, d_eweight, d_minv, d_parent, threshold);

  blocks = (g.edges + ThreadsPerBlock - 1) / ThreadsPerBlock;
  bool go_again = (g.edges > 0);
  while (go_again) {
    cudaMemset(d_go_again, false, sizeof(bool));
    kernel1<<<blocks, ThreadsPerBlock>>>(g.edges, d_go_again, d_parent, d_minv, d_slist, d_nlist, d_eweight);
    cudaMemcpy(&go_again, d_go_again, sizeof(bool), cudaMemcpyDeviceToHost);
    if (go_again) {
      kernel2<<<blocks, ThreadsPerBlock>>>(g.edges, d_parent, d_minv, d_inMST, d_slist, d_nlist, d_eweight);
      kernel3<<<blocks, ThreadsPerBlock>>>(g.edges, d_parent, d_minv, d_slist, d_nlist);
    }
  }

  cudaDeviceSynchronize();
  gettimeofday(&end, NULL);
//  printf("Dev%c: %12.9f s\n", filter ? '+' : '-', end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0);
  printf("%12.9f\n", end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0);

  cudaMemcpy(inMST, d_inMST, g.edges * sizeof(bool), cudaMemcpyDeviceToHost);

  cudaFree(d_inMST);
  cudaFree(d_parent);
  cudaFree(d_minv);
  cudaFree(d_go_again);
  cudaFree(d_nindex);
  cudaFree(d_slist);
  cudaFree(d_nlist);
  cudaFree(d_eweight);

  CheckCuda(__LINE__);

  return inMST;
}

static void verify(const ECLgraph& g, const bool* const cpuMSTedges, const bool* const gpuMSTedges)
{
  int bothMST = 0, neitherMST = 0, onlyCpuMST = 0, onlyGpuMST = 0;
  ull cpuMSTweight = 0, gpuMSTweight = 0;

  for (int j = 0; j < g.edges; j++) {
    const bool inCpuMST = cpuMSTedges[j];
    const bool inGpuMST = gpuMSTedges[j];
    if (inCpuMST && inGpuMST) bothMST++;
    if (!inCpuMST && !inGpuMST) neitherMST++;
    if (!inCpuMST && inGpuMST) onlyGpuMST++;
    if (inCpuMST && !inGpuMST) onlyCpuMST++;
    if (gpuMSTedges[j]) gpuMSTweight += g.eweight[j];
    if (cpuMSTedges[j]) cpuMSTweight += g.eweight[j];
  }

  if ((gpuMSTweight != cpuMSTweight) || (onlyGpuMST != 0) || (onlyCpuMST != 0)) {
    printf("ERROR: results differ!\n\n");
  } else {
//    printf("all good\n\n");
  }
}

int main(int argc, char* argv[])
{
  if (argc != 2) {
    printf("USAGE: %s input_graph\n", argv[0]);
    exit(-1);
  }
  ECLgraph g = readECLgraph(argv[1]);

  printf("input: %s\n", argv[1]);

  // assign weights if needed
  if (g.eweight == NULL) {
    g.eweight = new int [g.edges];
    for (int i = 0; i < g.nodes; i++) {
      for (int j = g.nindex[i]; j < g.nindex[i + 1]; j++) {
        const int k = g.nlist[j];
        g.eweight[j] = 1 + ((i * k) % g.nodes);
        if (g.eweight[j] < 0) g.eweight[j] = -g.eweight[j];
      }
    }
  }

  cudaSetDevice(Device);
  cudaDeviceProp deviceProp;
  cudaGetDeviceProperties(&deviceProp, Device);
  if ((deviceProp.major == 9999) && (deviceProp.minor == 9999)) {
    fprintf(stderr, "ERROR: there is no CUDA capable device\n\n");
    exit(-1);
  }

  // run GPU code
  bool* gpuMSTedges;
  for (int i = 0; i < RUNS; i++) {
    gpuMSTedges = gpuMST<false>(g, INT_MAX);
  }

  // run CPU code and compare result
  bool* cpuMSTedges = cpuMST(g);
  verify(g, cpuMSTedges, gpuMSTedges);

  freeECLgraph(g);
  delete [] gpuMSTedges;
  delete [] cpuMSTedges;
  return 0;
}
