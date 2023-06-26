#!/bin/bash
echo 'Building cuGraph'

export CUGRAPH_HOME=$(pwd)/cugraph
git clone https://github.com/rapidsai/cugraph.git $CUGRAPH_HOME
cd $CUGRAPH_HOME
conda env create --name cugraph_dev --file conda/environments/all_cuda-118_arch-x86_64.yaml
conda env update --name cugraph_dev --file conda/environments/all_cuda-118_arch-x86_64.yaml
conda activate cugraph_dev
cd ..
git clone https://github.com/rapidsai/raft.git
cd raft/
build.sh libraft
cd $CUGRAPH_HOME
cp ../mst_test.cu cpp/tests/tree/mst_test.cu
cd cpp/
mkdir build
cd build/
cmake ..
make -j 16
cd tests
make MST_TEST -j 16
cp MST_TEST ../../../../cugraph_double
cd ../../../../
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/cugraph/cpp/build/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/cugraph/cpp/build/libcugraph.so

echo 'Converting inputs'
cd ../inputs/
ln -s ../../Inputs inputs

g++ -O3 -march=native ecl2mtx_genweights_cugraph.cpp -o gconv

./gconv inputs/2d-2e20.sym.egr 2d-2e20.sym.egr.mtx
./gconv inputs/amazon0601.egr amazon0601.egr.mtx
./gconv inputs/as-skitter.egr as-skitter.egr.mtx
./gconv inputs/citationCiteseer.egr citationCiteseer.egr.mtx
./gconv inputs/cit-Patents.egr cit-Patents.egr.mtx
./gconv inputs/coPapersDBLP.egr coPapersDBLP.egr.mtx
./gconv inputs/delaunay_n24.egr delaunay_n24.egr.mtx
./gconv inputs/europe_osm.egr europe_osm.egr.mtx
./gconv inputs/in-2004.egr in-2004.egr.mtx
./gconv inputs/internet.egr internet.egr.mtx
./gconv inputs/kron_g500-logn21.egr kron_g500-logn21.egr.mtx
./gconv inputs/r4-2e23.sym.egr r4-2e23.sym.egr.mtx
./gconv inputs/rmat16.sym.egr rmat16.sym.egr.mtx
./gconv inputs/rmat22.sym.egr rmat22.sym.egr.mtx
./gconv inputs/soc-LiveJournal1.egr soc-LiveJournal1.egr.mtx
./gconv inputs/USA-road-d.NY.egr USA-road-d.NY.egr.mtx
./gconv inputs/USA-road-d.USA.egr USA-road-d.USA.egr.mtx

echo 'Done building cuGraph'