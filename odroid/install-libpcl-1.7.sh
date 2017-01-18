#!/bin/bash
FROM_GIT=False
PROJECT_DIR=~/ANPL/code/3rdparty
PCL_VER=1.7.2
FOLDER_NAME=pcl-$PCL_VER
FILE_NAME=$FOLDER_NAME.zip
LINK="https://github.com/PointCloudLibrary/pcl/archive/pcl-$PCL_VER.zip"
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/ -DCMAKE_CXX_FLAGS=-std=c++11 -DCMAKE_BUILD_TYPE=Release"

if [ "$FROM_GIT" = True ]; then
    sudo add-apt-repository ppa:v-launchpad-jochen-sprickerhof-de/pcl
    sudo apt-get update
    sudo apt-get install libpcl-all -y
else
    rm -rf $PROJECT_DIR/$FOLDER_NAME
    cd ~/Downloads
    wget -O $FILE_NAME $LINK
    unzip $FILE_NAME -d $PROJECT_DIR
    rm -f ~/Downloads/$FILE_NAME
    cd $PROJECT_DIR/
    mv pcl-$FOLDER_NAME $FOLDER_NAME
    cd $FOLDER_NAME
    mkdir build && cd build
    cmake $CMAKE_FLAGS ..
    make -j4
    sudo make install -j4
fi

sudo apt-get install ros-$ROS_DISTRO-pcl-conversions -y
