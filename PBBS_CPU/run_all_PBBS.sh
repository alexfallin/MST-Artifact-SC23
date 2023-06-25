#!/bin/bash
echo 'PBBS MST runs'
echo 'Running all files...'

for FILE in inputs/*.pbbs
do
	echo $FILE >> pbbs_par_out.csv
    echo $FILE >> pbbs_ser_out.csv
	for i in $(seq 9)
    do
		./pbbs_parallel $FILE >> pbbs_par_out.csv
		./pbbs_serial $FILE >> pbbs_ser_out.csv 
	done
done

echo 'copying results to root directory'

cp pbbs_par_out.csv ..
cp pbbs_ser_out.csv ..