#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBNABO_VER=1.0.6
FOLDER_NAME=libnabo-$LIBNABO_VER
FILE_NAME=$FOLDER_NAME.zip

LINK=https://github.com/ethz-asl/libnabo/archive/$LIBNABO_VER.zip
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"

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
