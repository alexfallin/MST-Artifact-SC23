#!/bin/bash

date
date > output_ls_mst_cpu.txt

echo 'Running all files...'

for FILE in inputs/*
do
    if [[ $FILE == *.ls ]]
    then
        for i in $(seq 9)
        do
            echo -e '\n'
            echo $FILE
            echo -n $FILE >> output_ls_mst_cpu.txt
            echo -n ", " >> output_ls_mst_cpu.txt
	    echo $i >> output_ls_mst_cpu.txt
            ./minimum-spanningtree-cpu -t=32 $FILE >> output_ls_mst_cpu.txt
        done
    fi
done

date
date >> output_ls_mst_cpu.txt
