#!/bin/bash

a=$(ls -l /home/debian/skripts | wc -l) 
echo $a

for list in ${a[@]}; do
	echo $list
done

