#!/bin/bash
echo 'Cloning and building prerequsites'

echo 'moderngpu'
git clone https://github.com/moderngpu/moderngpu.git
cp -r moderngpu/ moderngpu_1.1

echo 'copy and checkout'
cd moderngpu_1.1
git checkout origin/branch_1.1
cd ..

echo 'Done with prerequsites'
