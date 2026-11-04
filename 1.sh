#!/bin/bash

set -euo pipefail

SOURCE="/home/debian/data"
DEST="/home/debian/backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIEVE="$DEST/backup_$DATE.tar.gz"

if [[ ! -d "$SOURCE" ]]; then
	echo "$SOURCE ne naiden"
	exit 1
fi

mkdir -p "$DEST"

tar -czf "$ARCHIEVE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

echo "$ARCHIEVE ($(du -h "$ARCHIEVE" | cut -f1))"
