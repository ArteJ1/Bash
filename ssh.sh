#!/bin/bash

set -euo pipefail

read -p "Введи сначала IP хоста, затем имя пользователя для генерации ssh ключа" ip name user

ssh-keygen -t ed25519 -C $user

{
echo "Host myserver
      HostName $ip
      User $name
      Port 22
      IdentityFile ~/.ssh/id_ed25519"
} >> ~/.ssh/config
