#!/bin/bash

set -euo pipefail

name=$1
date=$2

file_dir="/home/debian/skripts/${name}_${date}.log"

{
			journalctl -S "${date} 00:00:00" -U "${date} 23:59:59" | \
			awk '$5~"sudo" && $6=="'$name'" { print }' | \
		   	awk 'match($0, /COMMAND=(.|\/)\/?(.*)/, arr)  { print arr[0] }' | \
		   	awk -F"=" '{print $2}' | uniq -c | \
			awk 'BEGIN {print "COMMAND COUNT"}{ print $2, $1 } END {print "\n", "LOGIN:'$name'", "\n", "DATE:'$date'" }'| \
		        column -te	

} > "$file_dir"
