#!/bin/bash
echo 'Lonestar Runs'

for FILE in inputs/*.lsg
do
	for i in $(seq 9)
        do
            echo $FILE >> lonestar_mst_out.csv
            ./lonestar_mst -t=32 $FILE | grep TimerTotal >> lonestar_mst_out.csv
        done
	
done

echo 'copying results to root directory'

cp lonestar_mst_out.csv ..