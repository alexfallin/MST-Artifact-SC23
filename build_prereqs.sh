#!/bin/bash
echo 'Cloning and building prerequsites'

echo 'moderngpu'
git clone https://github.com/moderngpu/moderngpu.git
cp -r moderngpu/ moderngpu_1.1

cd moderngpu_1.1
git branch origin/branch_1.1
cd ..

# Below may be needed for some systems
#git clone https://github.com/oneapi-src/oneTBB.git

echo 'Done with prerequsites'
