#!/bin/bash
echo 'Building deoptimization tests'
nvcc -O3 -arch=sm_70 ECL-MST.cu -o ecl_mst
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards.cu -o ecl_mst_NAG
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards_NoWarp.cu -o ecl_mst_NAG_NW
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards_NoWarp_NoFilter.cu -o ecl_mst_NAG_NW_NF
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards_NoWarp_NoFilter_NoImplicitPathCompression.cu -o ecl_mst_NAG_NW_NF_NIPC
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards_NoWarp_NoFilter_NoImplicitPathCompression_NoOneDirection.cu -o ecl_mst_NAG_NW_NF_NIPC_NOD
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards_NoWarp_NoFilter_NoImplicitPathCompression_NoOneDirection_NoTuples.cu -o ecl_mst_NAG_NW_NF_NIPC_NOD_NT
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards_NoWarp_NoFilter_NoImplicitPathCompression_NoOneDirection_NoTuples_NoDataDriven.cu -o ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD
nvcc -O3 -arch=sm_70 ECL_MST_NoAtomicGuards_NoWarp_NoFilter_NoImplicitPathCompression_NoOneDirection_NoTuples_NoDataDriven_NoEdgeBased.cu -o ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_NEB

echo 'Creating symlink to inputs'
ln -s ../Inputs inputs

echo 'Done building deoptimization tests'