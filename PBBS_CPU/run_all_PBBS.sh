#!/bin/bash
echo 'PBBS MST runs'
echo 'Running all files...'

for FILE in inputs/*.pbbs
do
	echo $FILE >> pbbs_par_out.txt
    echo $FILE >> pbbs_ser_out.txt
	for i in $(seq 9)
    do
		./pbbs_parallel $FILE >> pbbs_par_out.txt
		./pbbs_serial $FILE >> pbbs_ser_out.txt 
	done
done

python parse_output_pbbs_both_cpu.py


echo 'copying results to root directory'

cp pbbs_par_out.csv ..
cp pbbs_ser_out.csv ..