#!/bin/bash
echo 'Building ECL-MST'
nvcc -O3 -arch=sm_70 ECL_MST.cu -o ecl_mst

echo 'Creating symlink to inputs'
ln -s ../Inputs inputs

echo 'Done building ECL-MST'
