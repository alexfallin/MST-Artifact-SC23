#!/bin/bash
echo 'UMinho MST Runs'
echo 'Running all files...'
for FILE in inputs/*.bu
do
        echo $FILE >> UMinho_gpu_out.csv
        echo $FILE >> UMinho_omp_out.csv
        for i in $(seq 9)
        do
                ./BoruvkaUMinho_GPU $FILE 512 | grep eclruntime >> UMinho_gpu_out.csv
                ./BoruvkaUMinho_OMP $FILE 32 | grep eclruntime >> UMinho_omp_out.csv
        done
done
echo 'copying results to root directory'

cp UMinho_*_out.csv ..