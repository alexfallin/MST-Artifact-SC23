#!/bin/bash
echo 'Building PBBS'
git clone https://github.com/cmuparlay/pbbsbench.git
cd pbbsbench
git submodule update --init
make minSpanningForest/parallelFilterKruskal
make minSpanningForest/serialMST
cp benchmarks/minSpanningForest/parallelFilterKruskal/MST ../pbbs_parallel
cp benchmarks/minSpanningForest/serialMST/MST ../pbbs_serial

echo 'Converting inputs'
cd ../inputs/
ln -s ../../Inputs inputs

g++ -O3 -march=native ecl2pbbs_genweights.cpp -o gconv

./gconv inputs/2d-2e20.sym.egr 2d-2e20.sym.egr.pbbs
./gconv inputs/amazon0601.egr amazon0601.egr.pbbs
./gconv inputs/as-skitter.egr as-skitter.egr.pbbs
./gconv inputs/citationCiteseer.egr citationCiteseer.egr.pbbs
./gconv inputs/cit-Patents.egr cit-Patents.egr.pbbs
./gconv inputs/coPapersDBLP.egr coPapersDBLP.egr.pbbs
./gconv inputs/delaunay_n24.egr delaunay_n24.egr.pbbs
./gconv inputs/europe_osm.egr europe_osm.egr.pbbs
./gconv inputs/in-2004.egr in-2004.egr.pbbs
./gconv inputs/internet.egr internet.egr.pbbs
./gconv inputs/kron_g500-logn21.egr kron_g500-logn21.egr.pbbs
./gconv inputs/r4-2e23.sym.egr r4-2e23.sym.egr.pbbs
./gconv inputs/rmat16.sym.egr rmat16.sym.egr.pbbs
./gconv inputs/rmat22.sym.egr rmat22.sym.egr.pbbs
./gconv inputs/soc-LiveJournal1.egr soc-LiveJournal1.egr.pbbs
./gconv inputs/USA-road-d.NY.egr USA-road-d.NY.egr.pbbs
./gconv inputs/USA-road-d.USA.egr USA-road-d.USA.egr.pbbs