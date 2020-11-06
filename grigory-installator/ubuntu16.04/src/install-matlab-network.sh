#!/bin/bash

#from https://help.ubuntu.com/community/MountIso
LINK_ICON=https://upload.wikimedia.org/wikipedia/commons/2/21/Matlab_Logo.png

sudo apt-get install nfs-common -y

sudo mkdir -p /media/matlab
sudo mount 132.68.1.41:/ccnfs/cccd/matlab /media/matlab
sudo mkdir -p /tmp/network
cat << EOF > network.lic
SERVER lm.technion.ac.il 001b24e02dd5 1700
USE_SERVER
EOF
sudo mv network.lic /tmp/network
sudo wget $LINK_ICON -O /usr/share/icons/matlab.png

cat << EOF > matlab.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Matlab
Icon=/usr/share/icons/matlab.png
Exec=bash -i -c "/usr/local/bin/matlab -desktop"
Comment=Start MATLAB - The Language of Technical Computing
Categories=Development;IDE;
Terminal=false
StartupWMClass=matlab
EOF
sudo mv matlab.desktop /usr/share/applications
cd /media/matlab
sudo ./install
sleep 2
sudo umount /media/matlab
