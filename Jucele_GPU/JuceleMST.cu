/*
	Programa: mst_cuda_semGB.c  (Versão 1)
	Descrição: Implementa o Algoritmo para árvore geradora mínima.
	Programadora: Jucele Vasconcellos
	Data: 25/08/2017
	Versão 3: sem o atomicAddD em Calcula_num_zerodiff
	Compilacao:	nvcc -arch sm_30 -o mst_cuda_semGB.exe mst_cuda_semGB.cu
	Execucao:	./st_cuda.exe in/grafo/grafo1000a cuda.out
	
	Entrada de dados: Este programa lê os dados de um grafo no formato
	8
	16
	4 5 0.35
	4 7 0.37
	5 7 0.28
	0 7 0.16
	1 5 0.32
	0 4 0.38
	2 3 0.17
	1 7 0.19
	0 2 0.26
	1 2 0.36
	1 3 0.29
	2 7 0.34
	6 2 0.40
	3 6 0.52
	6 0 0.58
	6 4 0.93

	sendo a primeira linha o número de vértices, a segunda linha o número de arestas
	e as linhas subsequentes as arestas v1 v2 custo
		
	Saída de Dados: Este programa produz um arquivo de saída as arestas que compõem a árvore geradora 
*/

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <sys/time.h>

// Grafo Original
typedef struct {
  unsigned int v, u;
  unsigned int grau_st;
} aresta;

typedef struct {
  int n, m;
  aresta* arestas;
  float* custos;
} grafo;

typedef struct {
  int v1, v2;
} aresta_E;


// Funções e Procedimentos

static void HandleError(cudaError_t err, const char* file, int line) {
  if (err != cudaSuccess) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), file, line);
    exit(EXIT_FAILURE);
  }
}

#define CHECK_ERROR(err) (HandleError(err, __FILE__, __LINE__))

grafo LeGrafo(char*);
__device__ double atomicAddD(double* address, float val);
__global__ void EncontraMenorAresta1(aresta*, float*, int*, int, int);
__global__ void EncontraMenorAresta2(aresta*, float*, int*, int, int);
__global__ void MarcarArestas_Strut(aresta*, int*, int);
__global__ void Calcula_num_zerodiff(aresta*, float*, int, int*, unsigned int*, unsigned int*, double*);
__global__ void Inicializa_arestasE_C(aresta*, int*, int, int*, aresta_E*, unsigned int*);
__global__ void AtualizaC_1(aresta_E*, int*, int*, int);
__global__ void DefineNovosVU(int*, int, char*, unsigned int*);
__global__ void AtualizaC_3(int*, int, char*);
__global__ void MarcarArestas(aresta*, int*, int, int);

// Função Principal
int main(int argc, char** argv) {
  grafo G;
  double tempoTotal, tempo1, tempo2;
  double tempo1p, tempo2p;
  int* SolutionEdgeSet;
  int SolutionSize, i, it;
  double SolutionVal;
  int num_zerodiff;
  FILE* Arq;

  int dimBloco, dimGrid;
  aresta* d_arestas;
  float* d_custos;
  int* d_SolutionEdgeSet;
  unsigned int* d_SolutionSize, * d_num_zerodiff;
  double* d_SolutionVal;
  int* d_menorAresta;
  int n;


  // Passo 1: Verificação de parâmetros
  // Passo 2: Leitura dos dados do grafo
  // Passo 3: Criação do grafo bipartido correspondente às arestas recebidas
  // Passo 4: Encontra a solução
  // Passo 4.1: Escolher arestas que comporão a strut
  // Passo 4.2: Calcular o num_zerodiff e computar novas componenetes conexas
  // Passo 4.3: Compactar o grafo


  // ==============================================================================
  // Passo 1: Verificação de parâmetros
  // ==============================================================================

  //Verificando os parametros
  if (argc < 3) {
    printf("\nParametros incorretos\n Uso: ./cms_seq.exe <ArqEntrada> <ArqSaida> <dimBloco> <S/N> onde:\n");
    printf("\t <ArqEntrada> (obrigatorio) - Nome do arquivo com as informações do grafo (número de vértices, número de arestas e arestas.\n");
    printf("\t <ArqSaida> (obrigatorio) - Nome do arquivo de saida.\n");
    printf("\t <S ou N> - Mostrar ou não as arestas da MST.\n");
    return 0;
  }
  //Define a dimensão do bloco fixada em 32 threads
  //dimBloco = 32;
  dimBloco = 64;

  // ==============================================================================
  // Passo 2: Leitura dos dados do Grafo G
  // ==============================================================================
//  tempo1p = (double) clock() / CLOCKS_PER_SEC;
  G = LeGrafo(argv[1]);
  n = G.n;
// 	printf("****************************\n");
// 	printf("****** GRAFO ORIGINAL ******\n");
// 	MostraGrafoOriginal(GO);

// 	printf("Grafo de entrada lido\n");

  //Alocação de variável para armazenar solução
  SolutionEdgeSet = (int*) malloc((G.n - 1) * sizeof(int));
  //Aloca memória no device para as arestas da d_SolutionEdgeSet
  CHECK_ERROR(cudaMalloc((void**) &d_SolutionEdgeSet, G.n * sizeof(int)));
  SolutionSize = 0;
  SolutionVal = 0;
  //Aloca memória no device para a variável d_SolutionSize
  CHECK_ERROR(cudaMalloc((void**) &d_SolutionSize, sizeof(unsigned int)));
  //Inicializa d_SolutionSize com 0
  CHECK_ERROR(cudaMemset(d_SolutionSize, 0, sizeof(unsigned int)));
  //Aloca memória no device para a variável d_SolutionVal
  CHECK_ERROR(cudaMalloc((void**) &d_SolutionVal, sizeof(double)));
  //Inicializa d_SolutionVal com 0
  CHECK_ERROR(cudaMemset(d_SolutionVal, 0, sizeof(double)));
  //Aloca memória no device para a variável d_num_zerodiff
  CHECK_ERROR(cudaMalloc((void**) &d_num_zerodiff, sizeof(unsigned int)));

//  tempo2p = (double) clock() / CLOCKS_PER_SEC;
//  	printf("Tempo Passo 2: %lf\n", tempo2p - tempo1p);

  // ==============================================================================
  // Passo 3: Tranfere informações para device e inicializa variáveis
  // ==============================================================================
  //Iniciando contagem do tempo
//	tempo1 = (double) clock( ) / CLOCKS_PER_SEC;
//	tempo1p = (double) clock( ) / CLOCKS_PER_SEC;

  //Aloca memória no device para as arestas do grafo
  CHECK_ERROR(cudaMalloc((void**) &d_arestas, G.m * sizeof(aresta)));
  //Copia as arestas do grafo do host para o device
  CHECK_ERROR(cudaMemcpy(d_arestas, G.arestas, G.m * sizeof(aresta), cudaMemcpyHostToDevice));

  //Aloca memória no device para as arestas do grafo
  CHECK_ERROR(cudaMalloc((void**) &d_custos, G.m * sizeof(float)));
  //Copia as arestas do grafo do host para o device
  CHECK_ERROR(cudaMemcpy(d_custos, G.custos, G.m * sizeof(float), cudaMemcpyHostToDevice));

  //Aloca memória no device para o vetor d_menorAresta
  CHECK_ERROR(cudaMalloc((void**) &d_menorAresta, G.n * sizeof(int)));


//	tempo2p = (double) clock( ) / CLOCKS_PER_SEC;
//  	printf("Tempo Passo 3: %lf\n", tempo2p - tempo1p);

  // ==============================================================================
  // Passo 4: Encontra solução
  // ==============================================================================

  timeval start, end;
  gettimeofday(&start, NULL);

  it = 0;
  num_zerodiff = 0;
  while (num_zerodiff != 1) {
    // ==============================================================================
    // Passo 4.1: Escolher arestas que comporão a strut
    // ==============================================================================
//		tempo1p = (double) clock( ) / CLOCKS_PER_SEC;

    //Inicializa d_menorAresta com -1
    CHECK_ERROR(cudaMemset(d_menorAresta, -1, G.n * sizeof(int)));

    //Chama kernel para encontrar menorAresta de cada v
    dimGrid = ((G.m - 1) / dimBloco) + 1;
    EncontraMenorAresta1<<<dimGrid, dimBloco>>>(d_arestas, d_custos, d_menorAresta, G.m, G.n);
// 		if(it >= 0)
// 		{
// 			printf("Após EncontraMenorAresta1\n");
// 			int *h_menorAresta;
// 			h_menorAresta = (int *) malloc(G.n * sizeof(int)); 
// 			CHECK_ERROR(cudaMemcpy(h_menorAresta, d_menorAresta, G.n * sizeof(int), cudaMemcpyDeviceToHost));
// 			for(i = 0; i < n; i++)
// 				printf("MenorAresta[%d] = %d\n", i, h_menorAresta[i]);
// 			free(h_menorAresta);
// 		}
    dimGrid = ((G.m - 1) / dimBloco) + 1;
    EncontraMenorAresta2<<<dimGrid, dimBloco>>>(d_arestas, d_custos, d_menorAresta, G.m, G.n);
// 		if(it >= 0)
// 		{
// 			printf("Após EncontraMenorAresta2\n");
// 			int *h_menorAresta;
// 			h_menorAresta = (int *) malloc(G.n * sizeof(int)); 
// 			CHECK_ERROR(cudaMemcpy(h_menorAresta, d_menorAresta, G.n * sizeof(int), cudaMemcpyDeviceToHost));
// 			for(i = 0; i < n; i++)
// 				printf("MenorAresta[%d] = %d\n", i, h_menorAresta[i]);
// 			free(h_menorAresta);
// 		}


    //Chama kernel para marcar arestas da Strut
    dimGrid = ((n - 1) / dimBloco) + 1;
    MarcarArestas_Strut<<<dimGrid, dimBloco>>>(d_arestas, d_menorAresta, n);

//		tempo2p = (double) clock( ) / CLOCKS_PER_SEC;
//  		printf("Tempo Passo 4.1: %lf\n", tempo2p - tempo1p);

    // ==============================================================================
    // Passo 4.2: Calcular o num_zerodiff
    // ==============================================================================
//		tempo1p = (double) clock( ) / CLOCKS_PER_SEC;

    //Inicializa d_num_zerodiff com 0
    CHECK_ERROR(cudaMemset(d_num_zerodiff, 0, sizeof(unsigned int)));

    //Chama kernel para calcular num_zerodiff e preencher SolutionEdgeSet
    dimGrid = ((G.m - 1) / dimBloco) + 1;
    Calcula_num_zerodiff<<<dimGrid, dimBloco>>>(d_arestas, d_custos, G.m, d_SolutionEdgeSet, d_SolutionSize, d_num_zerodiff, d_SolutionVal);

    CHECK_ERROR(cudaMemcpy(&num_zerodiff, d_num_zerodiff, sizeof(unsigned int), cudaMemcpyDeviceToHost));

//		tempo2p = (double) clock( ) / CLOCKS_PER_SEC;
//   		printf("Tempo Passo 4.2: %lf     it = %d     num_zerodiff = %d     SolutionSize = %d\n", tempo2p - tempo1p, it, num_zerodiff, SolutionSize);

    // ==============================================================================
    // Passo 4.3: Compactar o grafo
    // ==============================================================================
    if (num_zerodiff != 1) {
      // ==============================================================================
      // Passo 4.3.1: Computar componenetes conexas
      // ==============================================================================
//			tempo1p = (double) clock( ) / CLOCKS_PER_SEC;

      //Declara variável d_aux
      unsigned int* d_aux;
      //Aloca memória no device para a variável d_aux
      CHECK_ERROR(cudaMalloc((void**) &d_aux, sizeof(unsigned int)));
      //Inicializa d_aux com 0
      CHECK_ERROR(cudaMemset(d_aux, 0, sizeof(unsigned int)));

      //Declara variável d_arestasE
      aresta_E* d_arestasE;
      //Aloca memória no device para a variável d_arestasE
      CHECK_ERROR(cudaMalloc((void**) &d_arestasE, n * sizeof(aresta_E)));

      //Declara variável d_CD
      int* d_C;
      //Aloca memória no device para a variável d_CD
      CHECK_ERROR(cudaMalloc((void**) &d_C, n * sizeof(int)));

      //Chama kernel para inicializar d_arestasE e d_C
      dimGrid = ((n - 1) / dimBloco) + 1;
      Inicializa_arestasE_C<<<dimGrid, dimBloco>>>(d_arestas, d_menorAresta, n, d_C, d_arestasE, d_aux);

      int h_fim, * d_fim;
      CHECK_ERROR(cudaMalloc((void**) &d_fim, sizeof(int)));
      dimGrid = ((n - 1 - num_zerodiff) / dimBloco) + 1;
      do {
        h_fim = 0;
        CHECK_ERROR(cudaMemcpy(d_fim, &h_fim, sizeof(int), cudaMemcpyHostToDevice));
        AtualizaC_1<<<dimGrid, dimBloco>>>(d_arestasE, d_C, d_fim, n - num_zerodiff);
        CHECK_ERROR(cudaMemcpy(&h_fim, d_fim, sizeof(int), cudaMemcpyDeviceToHost));
      } while (h_fim == 1);

      CHECK_ERROR(cudaDeviceSynchronize());

      //Declara variável d_aux2
      char* d_aux2;
      //Aloca memória no device para a variável d_aux2
      CHECK_ERROR(cudaMalloc((void**) &d_aux2, n * sizeof(char)));
      //Inicializa d_aux2 com 0
      CHECK_ERROR(cudaMemset(d_aux2, 0, n * sizeof(char)));
      //Inicializa d_aux com 0
      CHECK_ERROR(cudaMemset(d_aux, 0, sizeof(unsigned int)));
      //Chama kernel para atualizar d_C
      dimGrid = ((n - 1) / dimBloco) + 1;
// 			printf("Vou chamar DefineNovosVU para dimGrid = %d  e  dimBloco = %d   com n = %d\n", dimGrid, dimBloco, n);
      DefineNovosVU<<<dimGrid, dimBloco>>>(d_C, n, d_aux2, d_aux);

      CHECK_ERROR(cudaDeviceSynchronize());

      //Chama kernel para atualizar d_C
      dimGrid = ((n - 1) / dimBloco) + 1;
      AtualizaC_3<<<dimGrid, dimBloco>>>(d_C, n, d_aux2);

      //Liberando variáveis
      CHECK_ERROR(cudaFree(d_aux));
      CHECK_ERROR(cudaFree(d_arestasE));
      CHECK_ERROR(cudaFree(d_fim));
      CHECK_ERROR(cudaFree(d_aux2));

//			tempo2p = (double) clock( ) / CLOCKS_PER_SEC;
//  			printf("Tempo Passo 4.3.1: %lf\n", tempo2p - tempo1p);

      // ==============================================================================
      // Passo 4.3.2: Marcar arestas
      // ==============================================================================
//			tempo1p = (double) clock( ) / CLOCKS_PER_SEC;

      //Marca as arestas para remoção
      dimGrid = ((G.m - 1) / dimBloco) + 1;
      MarcarArestas<<<dimGrid, dimBloco>>>(d_arestas, d_C, G.m, G.n);

      CHECK_ERROR(cudaDeviceSynchronize());

      CHECK_ERROR(cudaFree(d_C));


// 			aresta *h_arestas;
// 			h_arestas = (aresta *) malloc(G.m * sizeof(aresta)); 
// 			CHECK_ERROR(cudaMemcpy(h_arestas, d_arestas, G.m * sizeof(aresta), cudaMemcpyDeviceToHost));
// 			for(i = 0; i < G.m; i++)
// 				if(h_arestas[i].v != G.n)
// 					printf("Aresta[%d]     v = %d    u = %d\n", i, h_arestas[i].v, h_arestas[i].u);
// 			free(h_arestas);


//			tempo2p = (double) clock( ) / CLOCKS_PER_SEC;
//  			printf("Tempo Passo 4.3.2: %lf\n", tempo2p - tempo1p);		
    }

    it++;
    n = num_zerodiff;
  } // fim while(num_zerodiff != 1)
  gettimeofday(&end, NULL);
  printf("%12.9f s\n", end.tv_sec - start.tv_sec + (end.tv_usec - start.tv_usec) / 1000000.0);


  // Copia a Solução para o host
// 	CHECK_ERROR(cudaMemcpy(&SolutionVal, d_SolutionVal, sizeof(double), cudaMemcpyDeviceToHost));
  CHECK_ERROR(cudaMemcpy(&SolutionSize, d_SolutionSize, sizeof(unsigned int), cudaMemcpyDeviceToHost));
  CHECK_ERROR(cudaMemcpy(SolutionEdgeSet, d_SolutionEdgeSet, (G.n - 1) * sizeof(int), cudaMemcpyDeviceToHost));

  SolutionVal = 0;
  for (i = 0; i < SolutionSize; i++)
    SolutionVal += G.custos[SolutionEdgeSet[i]];

//	tempo2 = (double) clock( ) / CLOCKS_PER_SEC;
//	tempoTotal = tempo2 - tempo1;
//
//	printf("%lf\n", tempoTotal);

  Arq = fopen(argv[2], "a");
  fprintf(Arq, "\n*** Input file: %s\n", argv[1]);
  fprintf(Arq, "Total Time: %lf\n", tempoTotal);
  fprintf(Arq, "Number of iterations: %d\n", it);
  fprintf(Arq, "SolutionSize: %d\n", SolutionSize);
  fprintf(Arq, "SolutionValue: %f\n", SolutionVal);

  if ((argc == 4) && (argv[3][0] == 'S' || argv[3][0] == 's')) {
    fprintf(Arq, "*** MST formed by %d edges\n", SolutionSize);
    for (i = 0; i < SolutionSize; i++)
      fprintf(Arq, "Edge %d - %d\n", G.arestas[SolutionEdgeSet[i]].v, G.arestas[SolutionEdgeSet[i]].u);
  }
  fclose(Arq);


  // Liberando variávais alocadas no device
  CHECK_ERROR(cudaFree(d_SolutionEdgeSet));
  CHECK_ERROR(cudaFree(d_SolutionSize));
  CHECK_ERROR(cudaFree(d_SolutionVal));
  CHECK_ERROR(cudaFree(d_num_zerodiff));
  CHECK_ERROR(cudaFree(d_arestas));
  CHECK_ERROR(cudaFree(d_custos));
  CHECK_ERROR(cudaFree(d_menorAresta));

  // Liberando variávais alocadas no host
  free(G.arestas);
  free(G.custos);
  free(SolutionEdgeSet);

  return 0;

}

// ==============================================================================
// Função LeGrafo:  Lê as informações do Grafo de um arquivo e armazena em uma 
//                  estrutura
// ==============================================================================
grafo LeGrafo(char* Arquivo) {
  int i, aux;
  grafo G;
  FILE* Arq;

  Arq = fopen(Arquivo, "r");

  i = 0;
  fscanf(Arq, "%d", &i);
  G.n = i;

  fscanf(Arq, "%d", &i);
  G.m = i;

  G.arestas = (aresta*) malloc(G.m * sizeof(aresta));
  G.custos = (float*) malloc(G.m * sizeof(float));

  for (i = 0; i < G.m; i++) {
    fscanf(Arq, "%d", &G.arestas[i].u);
    fscanf(Arq, "%d", &G.arestas[i].v);
    if (G.arestas[i].v > G.arestas[i].u) {
      aux = G.arestas[i].v;
      G.arestas[i].v = G.arestas[i].u;
      G.arestas[i].u = aux;
    }
    fscanf(Arq, "%f", &G.custos[i]);
    G.arestas[i].grau_st = 0;
  }

  fclose(Arq);
  return G;
}

__device__ double atomicAddD(double* address, float val) {
  unsigned long long int* address_as_ull = (unsigned long long int*) address;
  unsigned long long int old = *address_as_ull, assumed;
  do {
    assumed = old;
    old = atomicCAS(address_as_ull, assumed, __double_as_longlong(val + __longlong_as_double(assumed)));
  } while (assumed != old);
  return __longlong_as_double(old);
}

// ==============================================================================
// Função EncontraMenorAresta1:  Para cada vértice v encontra o id da aresta menor
// ==============================================================================
__global__ void EncontraMenorAresta1(aresta* arestas, float* custos, int* menorAresta, int m, int n) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  int x, aux;
  int old;

  if (id < m) {
    if (arestas[id].v != n) {
      x = arestas[id].v;
// 			printf("1.1 Aresta %d   v = %d   u = %d  custo = %f    menorAresta[%d] = %d\n", id, arestas[id].v, arestas[id].u, custos[id], x, menorAresta[x]);
      if ((menorAresta[x] == -1) ||
          (custos[menorAresta[x]] > custos[id]) ||
          ((custos[menorAresta[x]] == custos[id]) && (menorAresta[x] > id))) {
        aux = -1;
        // atomicCAS = atomic Compare And Swap
        // lê o conteúdo endereçado por menorAresta[x] e o armazena em old.
        // computa (old == aux ? meu_id: old)
        // ou seja se (old == aux) então menorAresta[x] = id
        //         senão menorAresta[x] = old
        // retorna old
        old = atomicCAS(&menorAresta[x], aux, id);
        if (old != aux) {
          while (((custos[old] > custos[id]) || ((custos[old] == custos[id]) && (old > id))) && (old != aux)) {
            aux = atomicCAS(&menorAresta[x], old, id);
            if (old != aux) {
              old = aux;
              aux = -1;
            }
          }// fim while((old > id) && (old != aux))
        } // fim if(old_id != aux)
// 				printf("1.2 Aresta %d   v = %d   u = %d  custo = %f    menorAresta[%d] = %d\n", id, arestas[id].v, arestas[id].u, custos[id], x, menorAresta[x]);
      } // fim if((menorAresta[x] == -1) || (menorAresta[x] > id))
    } // fim if(arestas[id].v != n)
  } //fim if( id < m )
}

// ==============================================================================
// Função EncontraMenorAresta2:  Para cada vértice v encontra o id da aresta menor
// ==============================================================================
__global__ void EncontraMenorAresta2(aresta* arestas, float* custos, int* menorAresta, int m, int n) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  int x, aux;
  int old;

  if (id < m) {
    if (arestas[id].v != n) {
      x = arestas[id].u;
// 			printf("2.1 Aresta %d   v = %d   u = %d  custo = %f    menorAresta[%d] = %d\n", id, arestas[id].v, arestas[id].u, custos[id], x, menorAresta[x]);
      if ((menorAresta[x] == -1) ||
          (custos[menorAresta[x]] > custos[id]) ||
          ((custos[menorAresta[x]] == custos[id]) && (menorAresta[x] > id))) {
        aux = -1;
        // atomicCAS = atomic Compare And Swap
        // lê o conteúdo endereçado por menorAresta[x] e o armazena em old.
        // computa (old == aux ? meu_id: old)
        // ou seja se (old == aux) então menorAresta[x] = id
        //         senão menorAresta[x] = old
        // retorna old
        old = atomicCAS(&menorAresta[x], aux, id);
        if (old != aux) {
          while (((custos[old] > custos[id]) || ((custos[old] == custos[id]) && (old > id))) && (old != aux)) {
            aux = atomicCAS(&menorAresta[x], old, id);
            if (old != aux) {
              old = aux;
              aux = -1;
            }
          }// fim while((old > id) && (old != aux))
        } // fim if(old_id != aux)
// 				printf("2.2 Aresta %d   v = %d   u = %d  custo = %f    menorAresta[%d] = %d\n", id, arestas[id].v, arestas[id].u, custos[id], x, menorAresta[x]);
      } // if((menorAresta[x] == -1) || (menorAresta[x] > id))
    } // fim if(arestas[id].v != n)
  } //fim if( id < m )
}

// ==============================================================================
// Função MarcarArestas_Strut:  Para cada vértice v marca aresta pertencente a strut
// ==============================================================================
__global__ void MarcarArestas_Strut(aresta* d_arestas, int* d_menorAresta, int n) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  if (id < n) {
    atomicInc(&d_arestas[d_menorAresta[id]].grau_st, UINT_MAX);
// 		printf("MenorAresta[%d] = %d\n", id, d_menorAresta[id]);
  }
}

// ==============================================================================
// Função Calcula_num_zerodiff:  Calcula o número de vértices zero diferença e
//                               preenche o vetor d_SolutionEdgeSet
// ==============================================================================
__global__ void Calcula_num_zerodiff(aresta* arestas, float* custos, int m, int* SolutionEdgeSet, unsigned int* SolutionSize, unsigned int* num_zerodiff, double* SolutionVal) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  int pos;

  if (id < m) {
    if (arestas[id].grau_st > 0) {
      pos = atomicInc(&SolutionSize[0], UINT_MAX);
      SolutionEdgeSet[pos] = id;
// 			atomicAddD(&SolutionVal[0], custos[id]);
      if (arestas[id].grau_st == 2) {
        pos = atomicInc(&num_zerodiff[0], UINT_MAX);
// 				printf("num_zerodiff = %d\n", num_zerodiff[0]);
      }
    }
  }
}

// ==============================================================================
// Função Inicializa_arestasE_CD:  Inicializa as variáveis CD, arestasE e arestasE_size
// ==============================================================================
__global__ void Inicializa_arestasE_C(aresta* arestas, int* menorAresta, int n, int* C, aresta_E* arestasE, unsigned int* arestasE_size) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  int pos;

  if (id < n) {
    if ((arestas[menorAresta[id]].grau_st == 1) || (((arestas[menorAresta[id]].grau_st == 2)) && (id == arestas[menorAresta[id]].v))) {
      pos = atomicInc(&arestasE_size[0], UINT_MAX);
      arestasE[pos].v1 = arestas[menorAresta[id]].v;
      arestasE[pos].v2 = arestas[menorAresta[id]].u;
// 			printf("Thread %d    arestasE[%d]   v1 = %d   v2 = %d\n", id, pos, arestasE[pos].v1, arestasE[pos].v2);
    }
    C[id] = id;
  }
}

// ==============================================================================
// Função AtualizaC_1: Atualiza vetor C para definição das componentes conexas
// ==============================================================================
__global__ void AtualizaC_1(aresta_E* arestasE, int* C, int* m, int n) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  int c1, c2, v1, v2;

  if (id < n) {
    v1 = arestasE[id].v1;
    v2 = arestasE[id].v2;
    c1 = C[v1];
    c2 = C[v2];
    if (c1 < c2) {
      atomicMin(&C[v2], c1);
      m[0] = 1;
    } else if (c2 < c1) {
      atomicMin(&C[v1], c2);
      m[0] = 1;
    }
  }
}

// ==============================================================================
// Função DefineNovosVU: Atualiza vetor C
// ==============================================================================
__global__ void DefineNovosVU(int* C, int n, char* marcador, unsigned int* num_comp) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  int pos;

  if (id < n) {
    if (C[id] == id) {
      pos = atomicInc(&num_comp[0], UINT_MAX);
      C[id] = pos;
      marcador[id] = 1;
      //printf("C2[%d] = %d\n", id, C[id]);
    }
  }
}

// ==============================================================================
// Função AtualizaC_3: Atualiza vetor C
// ==============================================================================
__global__ void AtualizaC_3(int* C, int n, char* marcador) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;

  if (id < n) {
    if (marcador[id] == 0) {
      C[id] = C[C[id]];
      //printf("C3[%d] = %d\n", id, C[id]);
    }
  }
}

// ==============================================================================
// Função MarcarArestas:  Marca as arestas do grafo a serem removidas
// ==============================================================================
__global__ void MarcarArestas(aresta* arestas, int* C, int m, int n) {
  int id = threadIdx.x + blockDim.x * blockIdx.x;
  int x, y;

  if (id < m) {
    if (arestas[id].v != n) {
      x = C[arestas[id].v];
      y = C[arestas[id].u];

      if (x != y) {
        arestas[id].v = x;
        arestas[id].u = y;
      } else {
        arestas[id].v = n;
        arestas[id].u = n;
      }
      arestas[id].grau_st = 0;
    }
  } //fim if( id < m )
}


