#!/bin/bash

FILE_NAME=cuda9.2.deb
LINK=https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda-repo-ubuntu1604-9-2-local_9.2.148-1_amd64
FROM_APT=false

if [ $FROM_APT = true ]; then
	# sudo apt-get autoremove cuda-9-2 
	sudo apt-get install cuda-9-2 -y
	exit
fi

cd ~/Downloads
wget -O $FILE_NAME $LINK
sudo dpkg -i $FILE_NAME
sudo apt-key add /var/cuda-repo-9-2-local/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda -y
rm -rf $FILE_NAME
