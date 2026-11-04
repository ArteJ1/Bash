#!/bin/bash

set -e

timeout=$1

while true; 
do
	one_minute=$(cat /proc/loadavg | awk '{ print $1 }')
	cpu_cores=$(nproc --all)
	result=$(echo "${one_minute} > ${cpu_cores}" | bc -l)
	if [[ $result -eq 1 ]]; then
		curl -s -L \
			-X POST https://api.telegram.org/bot$TOKEN/sendMessage
			-d chat_id=$CHAT_ID \
			-d text="TEST"
		echo "shit"
		echo "`date` --- $one_minute" >> /home/debian/log/load_average.log
		sleep $timeout
		continue
	fi
	echo "GOOD"
	echo $result
	echo $one_minute
	sleep $timeout
	echo "`date` --- $one_minute" >> /home/debian/log/load_average.log
done
