#!/bin/bash

set -euo pipefail

read -p "Введи название директорий: " first_dir second_dir third_dir
dirs=($first_dir $second_dir $third_dir)

if [ -d "/home/debian/dirs" ]; then
	rm -rf /home/debian/dirs
fi

mkdir /home/debian/dirs
homedir=/home/debian/dirs
counter=()

for count in ${dirs[@]}; do
	counter+=("$count")
	mkdir $homedir/"$count"

	if [[ $count == $first_dir ]]; then
		chmod -R 700 $homedir/"$count"
		ls -l $homedir | grep $first_dir | cut -d' ' -f1 
		echo "user"	
	elif [[ $count == $second_dir ]]; then
		chmod -R 070 $homedir/"$count"
		ls -l $homedir | grep $second_dir | cut -d' ' -f1 
		echo "group"
	elif [[ $count == $third_dir ]]; then
		chmod -R 007 $homedir/"$count"
		ls -l $homedir | grep $third_dir | cut -d' ' -f1  
		echo "others"
	fi	

done

proverka=$(ls $homedir | wc -l)

while [ "$proverka" -gt 0 ]; do
	proverka=$(($proverka - 1))

	for i in ${counter[$proverka]}; do	
		echo $i
	done

done	

	

