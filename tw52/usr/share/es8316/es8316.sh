clear
if [ ! "`whoami`" = "root" ]
then
    echo "Please run script as root."
    exit 1
else echo "Patching UCM files..."
fi
touch install.log
chmod 777 install.log

echo "Downloading And Extracting UCM files..."
PURGE_UNZIP=false && [ ! $(sudo bash -c "command -v unzip") ] && sudo apt -y install unzip > /dev/null 2>&1 && PURGE_UNZIP=true
sudo rm -rf UCM
sudo mkdir UCM
cd UCM
sudo wget --timeout=10 "https://github.com/plbossart/UCM/archive/master.zip" > /dev/null 2>&1
sudo unzip master.zip > /dev/null 2>&1
sudo rm -f master.zip
echo "Installing UCM Files..."
sudo mkdir -p /usr/share/alsa/ucm
sudo cp -rf UCM-master/* /usr/share/alsa/ucm
sudo cp -rf /usr/share/alsa/ucm/bytcr-rt5651/asound.state /var/lib/alsa
sudo rm -rf UCM-master
sudo mkdir /usr/share/alsa/ucm/bytcht-es8316 > install.log 2>&1
sudo wget --timeout=10 "https://github.com/kernins/linux-chwhi12/raw/master/configs/audio/ucm/bytcht-es8316/HiFi" -O /usr/share/alsa/ucm/bytcht-es8316/HiFi > /dev/null 2>&1
sudo wget --timeout=10 "https://github.com/kernins/linux-chwhi12/raw/master/configs/audio/ucm/bytcht-es8316/bytcht-es8316.conf" -O /usr/share/alsa/ucm/bytcht-es8316/bytcht-es8316.conf > /dev/null 2>&1
# add HdmiLpeAudio.conf
sed '1,/^exit$/d' < ../$0 | base64 -d > install.log 2>&1 | sudo tee $0.zip > /dev/null 2>&1
sudo unzip $0.zip > /dev/null 2>&1
sudo rm -f $0.zip
sudo mkdir -p /usr/share/alsa/cards > install.log 2>&1
sudo cp HdmiLpeAudio.conf /usr/share/alsa/cards > install.log 2>&1
cd ..
sudo rm -rf UCM
[ ${PURGE_UNZIP} ] && sudo apt -y purge unzip > /dev/null 2>&1
echo "Finished Installing UCM Files"


