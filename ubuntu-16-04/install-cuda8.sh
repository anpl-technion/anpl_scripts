#!/bin/bash

FILE_NAME=cuda8.deb
LINK=https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64-deb

wget -O $FILE_NAME $LINK
sudo dpkg -i $FILE_NAME
sudo apt-get update
sudo apt-get install cuda -y
