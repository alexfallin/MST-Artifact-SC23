#!/bin/bash
echo 'cuGraph runs'
echo 'Running all files...'

for FILE in inputs/*.mtx
do
	./cugraph_double $FILE >> cugraph_mst_out.csv
done

echo 'copying results to root directory'

cp cugraph_mst_out.csv ..