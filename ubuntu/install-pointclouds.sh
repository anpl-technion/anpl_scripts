#!/bin/bash
FROM_GIT=True
PROJECT_DIR=~/ANPL/code/3rdparty
PCL_VER1=1.7.2
PCL_VER2=1.8.0
FOLDER_NAME1=pcl-$PCL_VER1
FOLDER_NAME2=pcl-$PCL_VER2
FILE_NAME1=$FOLDER_NAME1.zip
FILE_NAME2=$FOLDER_NAME2.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/ -DCMAKE_CXX_FLAGS=-std=c++11"
if [ ! "$FROM_GIT" = True ]; then
    sudo add-apt-repository ppa:v-launchpad-jochen-sprickerhof-de/pcl
    sudo apt-get update
    sudo apt-get install libpcl-all -y
else
    rm -rf $PROJECT_DIR/$FOLDER_NAME1
    cd ~/Downloads
    wget -O $FILE_NAME1 "https://github.com/PointCloudLibrary/pcl/archive/pcl-$PCL_VER2.zip"
    unzip $FILE_NAME1 -d $PROJECT_DIR
    rm -f ~/Downloads/$FILE_NAME1
    cd $PROJECT_DIR/
    mv pcl-$FOLDER_NAME1 $FOLDER_NAME1
    cd $FOLDER_NAME1
    mkdir build
    cd build
    cmake $CMAKE_FLAGS ..
    make -j7       
    sudo make install -j7
fi

sudo apt-get install ros-indigo-pcl-conversions -y

if [ ! "$FROM_GIT" = True ]; then
    sudo add-apt-repository ppa:v-launchpad-jochen-sprickerhof-de/pcl
    sudo apt-get update
    sudo apt-get install libpcl-all -y
else
    rm -rf $PROJECT_DIR/$FOLDER_NAME2
    cd ~/Downloads
    wget -O $FILE_NAME2 "https://github.com/PointCloudLibrary/pcl/archive/pcl-$PCL_VER2.zip"
    unzip $FILE_NAME2 -d $PROJECT_DIR
    rm -f ~/Downloads/$FILE_NAME2
    cd $PROJECT_DIR/
    mv pcl-$FOLDER_NAME2 $FOLDER_NAME2
    cd $FOLDER_NAME2
    mkdir build
    cd build
    cmake $CMAKE_FLAGS ..
    make -j7       
    sudo make install -j7
fi
