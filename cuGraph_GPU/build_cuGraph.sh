#!/bin/bash
echo 'Building cuGraph'

export CUGRAPH_HOME=$(pwd)/cugraph
git clone https://github.com/rapidsai/cugraph.git $CUGRAPH_HOME
cd $CUGRAPH_HOME
conda env create --name cugraph_dev --file conda/environments/all_cuda-118_arch-x86_64.yaml
conda env update --name cugraph_dev --file conda/environments/all_cuda-118_arch-x86_64.yaml
conda activate cugraph_dev
./build.sh clean
cp ../mst_test.cu cpp/tests/tree/mst_test.cu
# Do this build a few times, it tends to fail for no reason
./build.sh libcugraph
./build.sh libcugraph 
./build.sh libcugraph 
./build.sh libcugraph 
./build.sh cugraph
cd cpp/build/tests/


export CUGRAPH_HOME=$(pwd)/cugraph
git clone https://github.com/rapidsai/cugraph.git $CUGRAPH_HOME
cd $CUGRAPH_HOME
cp ../mst_test.cu cpp/tests/tree/mst_test.cu
cd cpp/
mkdir build
cd build/
