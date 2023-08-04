#!/bin/bash
echo 'Building Jucele MST'
nvcc -O3 -arch=sm_70 JuceleMST.cu -o jucelemst

echo 'Downloading inputs in Jucele format'
cd inputs/
#ln -s ../../Inputs inputs
#g++ -O3 -march=native ecl2jucele_mst_genweights.cpp -o gconv

#./gconv inputs/2d-2e20.sym.egr 2d-2e20.sym.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/2d-2e20.sym.egr.jmst
#./gconv inputs/delaunay_n24.egr delaunay_n24.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/delaunay_n24.egr.jmst
#./gconv inputs/r4-2e23.sym.egr r4-2e23.sym.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/r4-2e23.sym.egr.jmst
#./gconv inputs/citationCiteseer.egr citationCiteseer.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/citationCiteseer.egr.jmst
#./gconv inputs/europe_osm.egr europe_osm.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/europe_osm.egr.jmst
#./gconv inputs/USA-road-d.NY.egr USA-road-d.NY.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/USA-road-d.NY.egr.jmst
#./gconv inputs/coPapersDBLP.egr coPapersDBLP.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/coPapersDBLP.egr.jmst
#./gconv inputs/internet.egr internet.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/internet.egr.jmst
#./gconv inputs/USA-road-d.USA.egr USA-road-d.USA.egr.jmst
wget -nc https://alexfallin.com/sc_ae_ad/USA-road-d.USA.egr.jmst

echo 'Done building and downloading inputs'