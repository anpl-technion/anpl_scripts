#!/bin/bash

for f in $(pwd)/src/*.sh; do 
	if grep -q "gcc" "$f"; then 
		echo $f 
	fi 
done \


