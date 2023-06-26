/**
 * @brief Connected-Component test program
 * @file
 */
#include "Static/ConnectedComponents/CC.cuh"
#include <StandardAPI.hpp>
#include <Graph/GraphStd.hpp>
#include <Util/CommandLineParam.hpp>

int exec(int argc, char* argv[]) {
    using namespace timer;
    using namespace hornets_nest;

    graph::GraphStd<vid_t, eoff_t> graph(graph::structure_prop::UNDIRECTED);
    CommandLineParam cmd(graph, argc, argv);

    HornetInit hornet_init(graph.nV(), graph.nE(), graph.csr_out_offsets(),
                           graph.csr_out_edges());
    HornetGraph hornet_graph(hornet_init);

    CC cc_multistep(hornet_graph);

    Timer<DEVICE> TM;
    TM.start();

    cc_multistep.run();

    TM.stop();
    TM.print("CC");

    auto is_correct = cc_multistep.validate();
    std::cout << (is_correct ? "\nCorrect <>\n\n" : "\n! Not Correct\n\n");
    return !is_correct;
}

int main(int argc, char* argv[]) {
  int ret = 0;
  {

    ret = exec(argc, argv);

  }

  return ret;
}
