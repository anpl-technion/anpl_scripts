#!/bin/bash

PROJECT_DIR=~/ANPL/code
PREFIX=/usr/ANPLprefix
FOLDER_NAME=planar_icp
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
if [ "$#" -ne  "0" ]; then
	for i in "$@"; do
	case $i in
	    -b=*|--branch=*)
		    BRANCH="${i#*=}" && shift # past argument=value
	    ;;
	    *)
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		echo "'${0##*/}' ${i}: Unknown argument provided. Please rerun script"    
		exit    
		;;
	esac
	done
else
    BRANCH=master
fi

sudo rm -rf $PROJECT_DIR/$FOLDER_NAME

cd $PROJECT_DIR
TMP=0
git clone -b $BRANCH https://bitbucket.org/ANPL/planar_icp $FOLDER_NAME && TMP=1
if [ $TMP -ne 1 ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 	echo "'${0##*/}' git clone error. Check if provided branch name is correct. Please rerun script."
	exit
fi
cd $FOLDER_NAME

mkdir build && cd build
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$PREFIX/lib/pkgconfig/
cmake $CMAKE_FLAGS ..
make 
sudo make install

sudo mkdir -p $PREFIX/include/$FOLDER_NAME
cd $PROJECT_DIR/$FOLDER_NAME/cpp
sudo cp -f *.h $PREFIX/include/$FOLDER_NAME
