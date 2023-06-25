#!/bin/bash
echo 'Building UMinho MST'

echo 'Cloning UMinho'
git clone https://github.com/Beatgodes/BoruvkaUMinho.git
cd BoruvkaUMinho/
# Copy files over
cp ../apps .
cp ../include .
cp ../src .
cp ../Makefile .
echo 'Building'
echo 'Copying executables'
cd ..

#echo 'oneTBB requirement'
#git clone https://github.com/oneapi-src/oneTBB.git
#cd oneTBB/
#cmake .
#cmake --build .

echo 'Converting inputs to UMinho format'
cd inputs
ln -s ../../Inputs inputs
g++ -O3 -march=native ecl2UMinho_genweights.cpp -o gconv

./gconv inputs/2d-2e20.sym.egr 2d-2e20.sym.egr.bu
./gconv inputs/amazon0601.egr amazon0601.egr.bu
./gconv inputs/as-skitter.egr as-skitter.egr.bu
./gconv inputs/citationCiteseer.egr citationCiteseer.egr.bu
./gconv inputs/cit-Patents.egr cit-Patents.egr.bu
./gconv inputs/coPapersDBLP.egr coPapersDBLP.egr.bu
./gconv inputs/delaunay_n24.egr delaunay_n24.egr.bu
./gconv inputs/europe_osm.egr europe_osm.egr.bu
./gconv inputs/in-2004.egr in-2004.egr.bu
./gconv inputs/internet.egr internet.egr.bu
./gconv inputs/kron_g500-logn21.egr kron_g500-logn21.egr.bu
./gconv inputs/r4-2e23.sym.egr r4-2e23.sym.egr.bu
./gconv inputs/rmat16.sym.egr rmat16.sym.egr.bu
./gconv inputs/rmat22.sym.egr rmat22.sym.egr.bu
./gconv inputs/soc-LiveJournal1.egr soc-LiveJournal1.egr.bu
./gconv inputs/USA-road-d.NY.egr USA-road-d.NY.egr.bu
./gconv inputs/USA-road-d.USA.egr USA-road-d.USA.egr.bu
