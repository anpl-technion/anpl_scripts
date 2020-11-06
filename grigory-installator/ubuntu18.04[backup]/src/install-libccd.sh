#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBCCD_VER=2.0
FOLDER_NAME=libccd-$LIBCCD_VER
FILE_NAME=$FOLDER_NAME.zip
LINK=https://github.com/danfis/libccd/archive/v$LIBCCD_VER.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
FROM_APT=true

if [ $FROM_APT = true ]; then
	# sudo apt-get autoremove libccd-dev 
	sudo apt-get install libccd-dev -y
	exit
fi
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
cd ~/Downloads
wget -O $FILE_NAME $LINK
mkdir -p $PROJECT_DIR
unzip $FILE_NAME -d $PROJECT_DIR
rm -f ~/Downloads/$FILE_NAME
cd $PROJECT_DIR/$FOLDER_NAME
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j7       
sudo make install -j7

