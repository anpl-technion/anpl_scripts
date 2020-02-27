#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBFCL_VER=0.5.0
FOLDER_NAME=libfcl-$LIBFCL_VER
FILE_NAME=$FOLDER_NAME.zip

LINK=https://github.com/flexible-collision-library/fcl/archive/$LIBFCL_VER.zip
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DFCL_BUILD_TESTS=OFF"
FROM_APT=false # should be in false in order for 'FindIt.cmake' macro to find it

TMP=0
if [ $FROM_APT = true ]; then
	# sudo apt-get autoremove libfcl-0.5-dev 
	sudo apt-get install libfcl-0.5-dev -y && TMP=1
	if [ $TMP -eq 1 ]; then
		echo "'${0##*/}' SUCCEED"
	else
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 		echo "'${0##*/}' FAILED"
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		exit
	fi 
	exit
fi

TMP=0
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
cd ~/Downloads
wget -O $FILE_NAME $LINK
mkdir -p $PROJECT_DIR
unzip $FILE_NAME -d $PROJECT_DIR
rm -f ~/Downloads/$FILE_NAME
cd $PROJECT_DIR/
mv fcl-$LIBFCL_VER $FOLDER_NAME
cd $FOLDER_NAME
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j4       
sudo make install -j4
