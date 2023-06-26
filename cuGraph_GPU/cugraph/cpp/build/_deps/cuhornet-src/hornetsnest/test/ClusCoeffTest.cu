/**
 * @brief Clustering coefficient test program
 * @file
 */

#include "HornetAlg.hpp"
#include <StandardAPI.hpp>
#include <Graph/GraphStd.hpp>
#include <Util/CommandLineParam.hpp>

#include "Static/ClusteringCoefficient/cc.cuh"

using namespace timer;
using namespace hornets_nest;

using HornetGraph = ::hornet::gpu::Hornet<vid_t>;

int exec(int argc, char* argv[]) {

    using namespace graph::structure_prop;
    using namespace graph::parsing_prop;

    graph::GraphStd<vid_t, eoff_t> graph(UNDIRECTED);
    graph.read(argv[1], SORT | PRINT_INFO);
    HornetInit hornet_init(graph.nV(), graph.nE(), graph.csr_out_offsets(),
                           graph.csr_out_edges());

    HornetGraph hornet_graph(hornet_init);
    //hornet_graph.print();
    ClusteringCoefficient cc(hornet_graph);
    cc.init();

    Timer<DEVICE> TM(5);
    TM.start();

    cc.run();

    TM.stop();
    TM.print("Computation time:");

    return 0;
}

int main(int argc, char* argv[]) {
  int ret = 0;
  {

    ret = exec(argc, argv);

  }

  return ret;
}
