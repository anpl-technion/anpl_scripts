#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
LIBCSM_VER=1.0.2
FOLDER_NAME=csm-$LIBCSM_VER
FILE_NAME=$FOLDER_NAME.zip
LINK=https://github.com/AndreaCensi/csm/archive/$LIBCSM_VER.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"

# The scripts gets a single argument or none
if [ "$#" -eq  "0" ]; then
    FROM_APT=false
else
    if [ "$#" -eq  "1" ]; then
    FROM_APT=$(echo $1 | sed "s/^--apt=\(.*\)$/\1/")
    else
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        echo "'${0##*/}' Too many arguments provided. Please rerun script"           
        exit 
    fi
fi

if [ $ROS_DISTRO = "kinetic" ] || [ $ROS_DISTRO = "indigo" ] ; then
    FROM_GIT=false
fi

sudo apt-get install libgsl-dev -y

if [ "$FROM_APT" = true ]; then
    sudo apt-get install ros-$ROS_DISTRO-csm    # supports indigo and kinetic
else
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
fi



