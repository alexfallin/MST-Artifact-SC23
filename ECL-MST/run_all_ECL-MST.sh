#!/bin/bash
echo 'ECL-MST Runs'
echo 'Running all files...'

for FILE in inputs/*.egr
do
	./ecl_mst $FILE >> ecl_mst_out.csv
done

echo 'copying results to root directory'

cp ecl_mst_out.csv ..