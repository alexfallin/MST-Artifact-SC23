#!/bin/bash
echo 'Gunrock runs'
echo 'Running all files...'

for FILE in inputs/*.mtx
do
	./gunrock_mst -m $FILE >> gunrock_mst_out.csv
done

echo 'copying results to root directory'

cp gunrock_mst_out.csv ..