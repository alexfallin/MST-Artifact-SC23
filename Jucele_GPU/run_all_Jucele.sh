#!/bin/bash
echo 'Jucele MST runs'

echo 'Running all files...'

for FILE in inputs/*.jmst
do
	echo $FILE >> jucele_mst_out.csv
	for i in $(seq 9)
	do
		./jucelemst $FILE lengths.out >> jucele_mst_out.csv
	done
done

echo 'copying results to root directory'

cp jucele_mst_out.csv ..