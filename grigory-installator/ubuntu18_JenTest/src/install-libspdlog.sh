#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBSPDLOG_VER=1.5.0
FOLDER_NAME=libspdlog-$LIBSPDLOG_VER
FILE_NAME=$FOLDER_NAME.zip
LINK=https://github.com/gabime/spdlog/archive/v$LIBSPDLOG_VER.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
FROM_APT=false

if [ $FROM_APT = true ]; then
	# sudo apt-get autoremove libspdlog-dev
	sudo apt-get install libspdlog-dev -y
	exit
fi


sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
cd ~/Downloads
wget -O $FILE_NAME $LINK
mkdir -p $PROJECT_DIR
unzip $FILE_NAME -d $PROJECT_DIR
rm -f ~/Downloads/$FILE_NAME
cd $PROJECT_DIR/
mv spdlog-$LIBSPDLOG_VER $FOLDER_NAME
cd $FOLDER_NAME
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j4      
sudo make install -j4

