#!/bin/bash
SDK_VER=2.5
FILE_NAME=ZED.run
LINK_CUDA9=https://download.stereolabs.com/zedsdk/$SDK_VER/ubuntu_cuda9
LINK_CUDA9_2=https://download.stereolabs.com/zedsdk/$SDK_VER/ubuntu


CUDA_VER=`cat /usr/local/cuda/version.txt | tr -dc '0-9,.'`
CUDA_MINOR_VER=`cat /usr/local/cuda/version.txt | tr -dc '0-9,.' | cut -d '.' -f2`

cd ~/Downloads/

if [ "$CUDA_MINOR_VER" == "0" ]; then
	wget -O $FILE_NAME $LINK_CUDA9 
fi

if [ "$CUDA_MINOR_VER" == "2" ]; then
	wget -O $FILE_NAME $LINK_CUDA9_2
fi

if [ "$CUDA_MINOR_VER" == "1" ]; then
	echo "install cuda 9.0 or 9.2"
	exit	
fi

chmod +x $FILE_NAME
$FILE_NAME
rm -rf $FILE_NAME
