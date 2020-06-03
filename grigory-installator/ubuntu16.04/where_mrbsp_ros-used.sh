#!/bin/bash

for f in $(pwd)/../ubuntu18.04/archive/*; do 
	if grep -q "graphviz" "$f"; then 
		echo $f 
	fi 
done 


