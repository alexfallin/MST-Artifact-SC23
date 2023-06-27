#!/bin/bash
echo 'Setting up all experiments'
echo 'Cloning and building prerequsites'

echo 'moderngpu'
git clone https://github.com/moderngpu/moderngpu.git
cp -r moderngpu/ moderngpu_1.1

echo 'copy and checkout'
cd moderngpu_1.1
git checkout origin/branch_1.1
cd ..

echo 'Done with prerequsites'

cd Inputs/
./download_inputs.sh
cd ..

cd Deoptimizations/
./build_ECL-MST_deopts.sh
cd ..

cd ECL-MST/
./build_ECL-MST.sh
cd ..

cd Jucele_GPU/
./build_Jucele.sh
cd ..

cd UMinho_BOTH/
./build_UMinho.sh
cd ..

cd PBBS_CPU/
./build_PBBS.sh
cd ..

cd Gunrock_GPU/
./build_Gunrock.sh
cd ..

cd cuGraph_GPU/
./build_cuGraph.sh
cd ..

cd Lonestar_CPU/
./build_Lonestar.sh
cd ..
'Done with setup'