#!/bin/bash
echo 'ECL-MST Deoptimized Runs'
echo 'Creating symlink to inputs'

ln -s ../../Inputs inputs

echo 'Running all files...'

for FILE in inputs/*.egr
do
	./mst $FILE >> ecl_mst_out.csv
done

echo 'copying results to root directory'

cp ecl_mst_out.csv ..
