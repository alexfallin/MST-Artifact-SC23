#include <utilities/base_fixture.hpp>
#include <utilities/test_utilities.hpp>

#include <cugraph/algorithms.hpp>
#include <cugraph/legacy/graph.hpp>

#include <raft/error.hpp>
#include <raft/handle.hpp>

#include <cuda_profiler_api.h>

#include <cmath>

#include "../src/converters/legacy/COOtoCSR.cuh"
#include <thrust/device_ptr.h>
#include <thrust/iterator/constant_iterator.h>
#include <thrust/reduce.h>

#include <sys/time.h>

int main(int argc, char* argv[]) {

  if (argc != 2) {
    printf("USAGE: %s input_graph\n", argv[0]);
    exit(-1);
  }

  printf("%s\n", argv[1]); //input

  FILE* fpin = fopen(argv[1], "r");

  int m, k, nnz;
  MM_typecode mc;

  cugraph::test::mm_properties<int>(fpin, 1, &mc, &m, &k, &nnz);

  // Allocate memory on host
  std::vector<int> cooRowInd(nnz), cooColInd(nnz);
  std::vector<double> cooVal(nnz), mst(m);

  // Read
  cugraph::test::mm_to_coo<int, double>(fpin, 1, nnz, &cooRowInd[0], &cooColInd[0], &cooVal[0], NULL);
  fclose(fpin);

  raft::handle_t handle;

  cugraph::legacy::GraphCOOView<int, int, double> G_coo(
      &cooRowInd[0], &cooColInd[0], &cooVal[0], m, nnz);
  auto G_unique = cugraph::coo_to_csr(G_coo);
  cugraph::legacy::GraphCSRView<int, int, double> G(G_unique->view().offsets,
                                                   G_unique->view().indices,
                                                   G_unique->view().edge_data,
                                                   G_unique->view().number_of_vertices,
                                                   G_unique->view().number_of_edges);

  cudaDeviceSynchronize();

  auto mst_edges1 = cugraph::minimum_spanning_tree<int, int, double>(handle, G);
  cudaDeviceSynchronize();

  timeval start, end;
  gettimeofday(&start, NULL);

  auto mst_edges = cugraph::minimum_spanning_tree<int, int, double>(handle, G);
  cudaDeviceSynchronize();

  gettimeofday(&end, NULL);
  printf("%12.9f s\n", end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0);

  auto expected_mst_weight = thrust::reduce(
      thrust::device_pointer_cast(G_unique->view().edge_data),
      thrust::device_pointer_cast(G_unique->view().edge_data) + G_unique->view().number_of_edges);

  auto calculated_mst_weight = thrust::reduce(
      thrust::device_pointer_cast(mst_edges->view().edge_data),
      thrust::device_pointer_cast(mst_edges->view().edge_data) + mst_edges->view().number_of_edges);

  printf("calc weight: %ld\n", (long)calculated_mst_weight);
  printf("calc weight: %lx\n", (long)calculated_mst_weight);
