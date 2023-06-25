#!/bin/bash
echo 'Building Gunrock'
git clone https://github.com/alexfallin/gunrock_w_timing.git
cd gunrock_w_timing
mkdir build
cd build
cmake .. -D CMAKE_CUDA_ARCHITECTURES=70
cp ../../mst.cu ../examples/algorithms/mst/
make mst
cp bin/mst ../../gunrock_mst


echo 'Converting inputs'
cd ../../inputs/
ln -s ../../Inputs inputs

g++ -O3 -march=native ecl2mtx_genweights_cugraph.cpp -o gconv

./gconv inputs/2d-2e20.sym.egr 2d-2e20.sym.egr.mtx
./gconv inputs/citationCiteseer.egr citationCiteseer.egr.mtx
./gconv inputs/coPapersDBLP.egr coPapersDBLP.egr.mtx
./gconv inputs/delaunay_n24.egr delaunay_n24.egr.mtx
./gconv inputs/europe_osm.egr europe_osm.egr.mtx
./gconv inputs/internet.egr internet.egr.mtx
./gconv inputs/r4-2e23.sym.egr r4-2e23.sym.egr.mtx
./gconv inputs/USA-road-d.NY.egr USA-road-d.NY.egr.mtx
./gconv inputs/USA-road-d.USA.egr USA-road-d.USA.egr.mtx

echo 'Done building Gunrock'