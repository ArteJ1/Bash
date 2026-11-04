#!/bin/bash

set -euo pipefail

read -p "Введите имя: " username
echo "$username"

read -s -p "Введите его пароль: " password
echo "Ok"

homedir=/home/"$username"
sshdir=/home/debian/.ssh/id_ed25519.pub

mkdir -p "$homedir"
mkdir $homedir/.ssh 
cp -rT /etc/skel "$homedir"
useradd -d "$homedir" -s /bin/bash -m "$username" 
chown -R $username:$username $homedir
passwd $username
cat $sshdir > $homedir/.ssh/authorized_keys

cat /etc/passwd | grep $username
