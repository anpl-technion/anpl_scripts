#!/bin/bash
FROM_GIT=True
PROJECT_DIR=~/ANPL/code/3rdparty
PCL_VER=1.7.2
FOLDER_NAME=pcl-$PCL_VER
FILE_NAME=$FOLDER_NAME.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/ -DCMAKE_CXX_FLAGS=-std=c++11"
if [ ! "$FROM_GIT" = True ]; then
    sudo add-apt-repository ppa:v-launchpad-jochen-sprickerhof-de/pcl
    sudo apt-get update
    sudo apt-get install libpcl-all -y
else
    rm -rf $PROJECT_DIR/$FOLDER_NAME
    cd ~/Downloads
    wget -O $FILE_NAME "https://github.com/PointCloudLibrary/pcl/archive/pcl-$PCL_VER.zip"
    unzip $FILE_NAME -d $PROJECT_DIR
    rm -f ~/Downloads/$FILE_NAME
    cd $PROJECT_DIR/
    mv pcl-$FOLDER_NAME $FOLDER_NAME
    cd $FOLDER_NAME
    mkdir build
    cd build
    cmake $CMAKE_FLAGS ..
    sudo make install -j7
fi
sudo apt-get install ros-indigo-pcl-conversions -y
