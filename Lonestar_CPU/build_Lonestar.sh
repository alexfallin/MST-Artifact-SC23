#!/bin/bash
echo 'Building Lonestar'
git clone https://github.com/IntelligentSoftwareSystems/Galois.git
cd Galois
SRC_DIR=$(pwd)
BUILD_DIR=$(pwd)/build/
mkdir -p $BUILD_DIR
cmake -S $SRC_DIR -B $BUILD_DIR -DCMAKE_BUILD_TYPE=Release
cd build/lonestar/analytics/cpu/spanningtree/
make
cp minimum-spanningtree-cpu $SRC_DIR/../lonestar_mst

echo 'Converting inputs'
cd $SRC_DIR/../inputs/
ln -s ../../Inputs inputs

g++ -O3 -march=native ecl2lsg_genweights.cpp -o gconv

./gconv inputs/2d-2e20.sym.egr 2d-2e20.sym.egr.lsg
./gconv inputs/amazon0601.egr amazon0601.egr.lsg
./gconv inputs/as-skitter.egr as-skitter.egr.lsg
./gconv inputs/citationCiteseer.egr citationCiteseer.egr.lsg
./gconv inputs/cit-Patents.egr cit-Patents.egr.lsg
./gconv inputs/coPapersDBLP.egr coPapersDBLP.egr.lsg
./gconv inputs/delaunay_n24.egr delaunay_n24.egr.lsg
./gconv inputs/europe_osm.egr europe_osm.egr.lsg
./gconv inputs/in-2004.egr in-2004.egr.lsg
./gconv inputs/internet.egr internet.egr.lsg
./gconv inputs/kron_g500-logn21.egr kron_g500-logn21.egr.lsg
./gconv inputs/r4-2e23.sym.egr r4-2e23.sym.egr.lsg
./gconv inputs/rmat16.sym.egr rmat16.sym.egr.lsg
./gconv inputs/rmat22.sym.egr rmat22.sym.egr.lsg
./gconv inputs/soc-LiveJournal1.egr soc-LiveJournal1.egr.lsg
./gconv inputs/USA-road-d.NY.egr USA-road-d.NY.egr.lsg
./gconv inputs/USA-road-d.USA.egr USA-road-d.USA.egr.lsg