#!/bin/bash
echo 'Running all comparison experiments'
cd ECL-MST/
./run_all_ECL-MST.sh
cd ..

cd Jucele_GPU/
./run_all_Jucele.sh
cd ..

cd UMinho_BOTH/
./run_all_UMinho.sh
cd ..

cd PBBS_CPU/
./run_all_PBBS.sh
cd ..

cd Gunrock_GPU/
./run_all_Gunrock.sh
cd ..

cd cuGraph_GPU/
./run_all_cuGraph.sh
cd ..

cd Lonestar_CPU/
./run_all_Lonestar.sh
cd ..
'Done running comparison experiments'