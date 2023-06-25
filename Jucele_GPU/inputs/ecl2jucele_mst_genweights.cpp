#include <stdlib.h>
#include <stdio.h>
#include "ECLgraph.h"

int main(int argc, char* argv[])
{
  printf("ECL to JuceleMST Graph Converter (%s)\n", __FILE__);
  printf("Copyright 2022 Texas State University\n");

  if (argc != 3) {fprintf(stderr, "USAGE: %s input_file_name output_file_name\n\n", argv[0]);  exit(-1);}

  ECLgraph g = readECLgraph(argv[1]);

  printf("%s\t#name\n%d\t#nodes\n%d\t#edges\n", argv[1], g.nodes, g.edges);
  if (g.eweight != NULL) printf("yes\t#weights\n"); else printf("no\t#weights\n");
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

  fprintf(fout, "%d\n", g.nodes);
  fprintf(fout, "%d\n", g.edges);
  for (int src = 0; src < g.nodes; src++) {
    for (int j = g.nindex[src]; j < g.nindex[src + 1]; j++) {
      fprintf(fout, "%d ", src + 1);
      fprintf(fout, "%d ", g.nlist[j] + 1);
      if (g.eweight != NULL) fprintf(fout, "%.2f\n", (float) g.eweight[j]);
      else fprintf(fout, "\n");
    }
  }

  fclose(fout);
  freeECLgraph(g);
  return 0;
}
