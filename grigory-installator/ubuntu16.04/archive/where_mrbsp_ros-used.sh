#!/bin/bash

for f in $(pwd)/src/*; do
	if grep -q "mrbsp_ros" "$f"; then
		echo $f 
	fi 
done 


