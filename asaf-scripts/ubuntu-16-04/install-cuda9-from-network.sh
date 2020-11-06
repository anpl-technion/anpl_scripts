#!/bin/bash

FILE_NAME=cuda9-repo.deb
LINK=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb

cd ~/Downloads
wget -O $FILE_NAME $LINK
sudo dpkg -i $FILE_NAME
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub

sudo apt-get update
sudo apt-get install cuda -y
rm -rf $FILE_NAME
