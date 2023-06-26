/**
 * @brief SSSP test program
 * @file
 */
#include "Static/ShortestPath/SSSP.cuh"
#include <StandardAPI.hpp>
#include <Graph/GraphStd.hpp>
#include <Graph/GraphWeight.hpp>
#include <Util/CommandLineParam.hpp>

int exec(int argc, char* argv[]) {
    using namespace timer;
    using namespace hornets_nest;

    graph::GraphStd<vid_t, eoff_t> graph;
    CommandLineParam cmd(graph, argc, argv,false);

    auto h_weights = new weight_t[graph.nE()];
    host::generate_randoms(h_weights, graph.nE(), 0, 100, 1);

    HornetInit hornet_init(graph.nV(), graph.nE(), graph.csr_out_offsets(),
                           graph.csr_out_edges());
    hornet_init.insertEdgeData(h_weights);

    HornetGraph hornet_graph(hornet_init);

    vid_t root = 0;
    if(argc==3)
        root = atoi(argv[2]);

    SSSP sssp(hornet_graph);
    sssp.set_parameters(root);

    Timer<DEVICE> TM;
    TM.start();

    sssp.run();

    TM.stop();
    TM.print("SSSP");
    return 1;
}

int main(int argc, char* argv[]) {
  int ret = 0;
  {

    ret = exec(argc, argv);

  }

  return ret;
}
