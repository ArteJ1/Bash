#!/bin/bash 

set -euo pipefail

login=$1
homedir=/home/debian/$login
var_dirs=(dir_user dir_group dir_other)
list=()

for name in ${var_dirs[@]}; do

    list+=($homedir/$name)
    mkdir -p $homedir/$name
    if [[ $(echo $name | grep user) ]]; then
	chmod -R 700 $homedir/$name
    elif [[ $(echo $name | grep group) ]]; then
        chmod -R 070 $homedir/$name
    elif [[ $(echo $name | grep other) ]]; then
        chmod -R 007 $homedir/$name
    fi

done

counter=$( ls $homedir | wc -l )
while [ $counter -gt 0 ]; do

    counter=$(( $counter - 1 ))
    access_rules=$(ls -ld ${list[$counter]} | cut -d' ' -f 1)
    type_rules=$(ls -ld ${list[$counter]} | cut -d'_' -f 2)

    if [[ ${access_rules:1} == "------rwx"  ]] && [[ $type_rules == other ]]; then
	echo $type_rules
    elif [[ ${access_rules:1} == "---rwx---"  ]] && [[ $type_rules == group ]]; then 
        echo $type_rules 
    elif [[ ${access_rules:1} == "rwx------"  ]] && [[ $type_rules == user ]]; then
        echo $type_rules
        echo $access_rules	
    fi
done
