#include <utilities/base_fixture.hpp>
#include <utilities/high_res_clock.h>
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

const int NUM_RUNS = 9;

static double median(double array[], const int n) {
  double median = 0;
  std::sort(array, array + n);
  if (n % 2 == 0) median = (array[(n - 1) / 2] + array[n / 2]) / 2.0;
  else median = array[n / 2];
  return median;
}

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
  std::vector<float> cooVal(nnz), mst(m);

  // Read
  cugraph::test::mm_to_coo<int, float>(fpin, 1, nnz, &cooRowInd[0], &cooColInd[0], &cooVal[0], NULL);
  fclose(fpin);

  raft::handle_t handle;

  cugraph::legacy::GraphCOOView<int, int, float> G_coo(
      &cooRowInd[0], &cooColInd[0], &cooVal[0], m, nnz);
  auto G_unique = cugraph::coo_to_csr(G_coo);
  cugraph::legacy::GraphCSRView<int, int, float> G(G_unique->view().offsets,
                                                   G_unique->view().indices,
                                                   G_unique->view().edge_data,
                                                   G_unique->view().number_of_vertices,
                                                   G_unique->view().number_of_edges);

  cudaDeviceSynchronize();

  auto mst_edges = cugraph::minimum_spanning_tree<int, int, float>(handle, G);
  cudaDeviceSynchronize();

  timeval start, end;

  double runtimes[NUM_RUNS];
  for (int i = 0; i < NUM_RUNS; i++) {
    gettimeofday(&start, NULL);

    mst_edges = cugraph::minimum_spanning_tree<int, int, float>(handle, G);
    cudaDeviceSynchronize();

    gettimeofday(&end, NULL);

    runtimes[i] = end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0;
  }

  printf("%12.9f s, float_ver\n", median(runtimes, NUM_RUNS));

  auto calculated_mst_weight = thrust::reduce(
      thrust::device_pointer_cast(mst_edges->view().edge_data),
      thrust::device_pointer_cast(mst_edges->view().edge_data) + mst_edges->view().number_of_edges);

//  printf("calc weight: %ld\n", (long)calculated_mst_weight);
//  printf("calc weight: %lx\n", (long)calculated_mst_weight);
//  std::cout << "calculated_mst_weight: " << calculated_mst_weight << std::endl;
//  std::cout << "number_of_MST_edges: " << mst_edges->view().number_of_edges << std::endl;
}
