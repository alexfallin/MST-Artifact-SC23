#include <stdlib.h>
#include <stdio.h>
#include "ECLgraph.h"

// This file takes in an ECL graph and outputs a PBBS-friendly weighted edge array

int main(int argc, char* argv[])
{
  printf("ECL to PBBS Graph Converter for MSF PBBS (%s)\n", __FILE__);
  printf("Copyright 2022 Texas State University\n");

  if (argc != 3) {fprintf(stderr, "USAGE: %s input_file_name output_file_name\n\n", argv[0]);  exit(-1);}

  ECLgraph g = readECLgraph(argv[1]);

  printf("%s\t#name\n%d\t#nodes\n%d\t#edges\n", argv[1], g.nodes, g.edges);

  // assign weights if needed
  if (g.eweight == NULL) {
    g.eweight = new int [g.edges];
    for (int i = 0; i < g.nodes; i++) {
      for (int j = g.nindex[i]; j < g.nindex[i + 1]; j++) {
        const int k = g.nlist[j];
        g.eweight[j] = 1 + ((i * k) % g.nodes);
        if (g.eweight[j] < 0) g.eweight[j] = - g.eweight[j];
      }
    }
    printf("added missing weights using ECL-MST method\n");
  }

  FILE* fout = fopen(argv[2], "wt");
  if (fout == NULL) {fprintf(stderr, "ERROR: could not open output file %s\n\n", argv[2]);  exit(-1);}

  fprintf(fout, "WeightedEdgeArray\n");
  for (int src = 0; src < g.nodes; src++) {
    for (int i = g.nindex[src]; i < g.nindex[src + 1]; i++) {
      int dst = g.nlist[i];
      float weight = float(g.eweight[i]);
      fprintf(fout, "%d %d %f\n", src, dst, weight);
    }
  }

  fclose(fout);
  freeECLgraph(g);
  return 0;
}

