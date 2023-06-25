#!/bin/bash

date > fkrusk.out
date > skrusk.out

echo 'Running all files...'

for FILE in inputs/*
do
	echo $FILE >> fkrusk.out
    echo $FILE >> skrusk.out	
	for i in $(seq 9)
    do
		./pbbs_parallel_fkrusk $FILE >> fkrusk.out
		./pbbs_serial $FILE >> skrusk.out 
	done
done

date >> fkrusk.out
date >> skrusk.out
