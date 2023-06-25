#!/bin/bash
echo 'Building Jucele MST'
nvcc -O3 -arch=sm_70 JuceleMST.cu -o jucelemst

echo 'Converting inputs to Jucele format'
cd inputs/
g++ -O3 -march=native ecl2jucele_mst_genweights.cpp -o gconv
