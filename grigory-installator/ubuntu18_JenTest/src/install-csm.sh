#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBCSM_VER=1.0.2
FOLDER_NAME=csm-$LIBCSM_VER
FILE_NAME=$FOLDER_NAME.zip
LINK=https://github.com/AndreaCensi/csm/archive/$LIBCSM_VER.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
FROM_GIT=True

if [ $ROS_DISTRO = "kinetic" ] || [ $ROS_DISTRO = "indigo" ] ; then
    FROM_GIT=False
fi

sudo apt-get install libgsl-dev -y

if [ "$FROM_GIT" = True ]; then
    sudo rm -rf $PROJECT_DIR/$FOLDER_NAME    
    cd ~/Downloads
    wget -O $FILE_NAME $LINK
    mkdir -p $PROJECT_DIR
    unzip $FILE_NAME -d $PROJECT_DIR
    rm -f ~/Downloads/$FILE_NAME
    cd $PROJECT_DIR/$FOLDER_NAME
    mkdir build && cd build
    cmake $CMAKE_FLAGS ..
    make -j4       
    sudo make install -j4
else
    sudo apt-get install ros-$ROS_DISTRO-csm    # supports indigo and kinetic
fi



