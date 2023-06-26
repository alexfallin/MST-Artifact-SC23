#!/bin/bash

date
date > cugraph_float.txt
date > cugraph_double.txt

echo 'Running all files...'

for FILE in converted_inputs/*.egr
do
			echo $FILE >> nohup.out
			
			./cugraph_double $FILE >> cugraph_double.txt
			./cugraph_float $FILE >> cugraph_float.txt
done

date
date >> cugraph_float.txt
date >> cugraph_double.txt

