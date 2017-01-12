#!/bin/bash

#from https://help.ubuntu.com/community/MountIso

sudo apt-get install nfs-common -y

sudo mkdir -p /media/matlab
sudo mount -o loop ~/iso-matlab/R2014b_glnxa64.iso /media/matlab -o noauto
sudo mkdir -p /tmp/network
cat << EOF > network.lic
SERVER lm.technion.ac.il 001b24e02dd5 1700
USE_SERVER
EOF
sudo mv network.lic /tmp/network
cd /media/matlab/
sudo ./install
sleep 2 
sudo umount /media/matlab
