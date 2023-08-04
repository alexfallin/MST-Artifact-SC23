#include <stdlib.h>
#include <stdio.h>
#include "ECLgraph.h"

int main(int argc, char* argv[])
{
  printf("ECL to Lonestar Graph Converter (%s)\n", __FILE__);
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

  FILE* fout = fopen(argv[2], "wb");
  if (fout == NULL) {fprintf(stderr, "ERROR: could not open output file %s\n\n", argv[2]);  exit(-1);}

  unsigned long version = 1, weightsize = 0, nodes = g.nodes, edges = g.edges;
  if (g.eweight != NULL) weightsize = 4;

  int cnt = fwrite(&version, sizeof(version), 1, fout);  if (cnt != 1) {fprintf(stderr, "ERROR: failed to write version\n");  exit(-1);}
  cnt = fwrite(&weightsize, sizeof(weightsize), 1, fout);  if (cnt != 1) {fprintf(stderr, "ERROR: failed to write weightsize\n");  exit(-1);}
  cnt = fwrite(&nodes, sizeof(nodes), 1, fout);  if (cnt != 1) {fprintf(stderr, "ERROR: failed to write nodes\n");  exit(-1);}
  cnt = fwrite(&edges, sizeof(edges), 1, fout);  if (cnt != 1) {fprintf(stderr, "ERROR: failed to write edges\n");  exit(-1);}

  long* nidx = (long*)malloc((g.nodes + 1) * sizeof(long));
  if (nidx == NULL) {fprintf(stderr, "ERROR: failed to allocate nidx\n\n");  exit(-1);}
  for (int i = 0; i < g.nodes + 1; i++) {
    nidx[i] = g.nindex[i];
  }

  cnt = fwrite(&nidx[1], sizeof(long), g.nodes, fout);  if (cnt != g.nodes) {fprintf(stderr, "ERROR: failed to write nidx\n");  exit(-1);}
  cnt = fwrite(g.nlist, sizeof(int), g.edges, fout);  if (cnt != g.edges) {fprintf(stderr, "ERROR: failed to write nlist\n");  exit(-1);}
  if (g.eweight != NULL) {
    if (g.edges % 2 != 0) {
      int dummy = 0;
      cnt = fwrite(&dummy, sizeof(int), 1, fout);  if (cnt != 1) {fprintf(stderr, "ERROR: failed to write dummy\n\n");  exit(-1);}
    }
    cnt = fwrite(g.eweight, sizeof(int), g.edges, fout);  if (cnt != g.edges) {fprintf(stderr, "ERROR: failed to write nlist\n");  exit(-1);}
  }
  fclose(fout);

  free(nidx);
  freeECLgraph(g);
  return 0;
}

