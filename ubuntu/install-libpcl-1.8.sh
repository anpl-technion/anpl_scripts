#!/bin/bash
PROJECT_DIR=~/ANPL/code/3rdparty
PCL_VER=1.8.0
FOLDER_NAME=pcl-$PCL_VER
FILE_NAME=$FOLDER_NAME.zip
LINK="https://github.com/PointCloudLibrary/pcl/archive/pcl-$PCL_VER.zip"
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/ -DCMAKE_CXX_FLAGS=-std=c++11 -DCMAKE_BUILD_TYPE=Release -DBUILD_GPU=ON"


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
make -j7       
sudo make install -j7
