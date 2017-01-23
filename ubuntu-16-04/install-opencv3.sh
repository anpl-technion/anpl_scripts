#!/bin/bash

PROJECT_DIR=~/ANPL/code/3rdparty
OPENCV_VER=3.1.0
OPEN_CV_FOLDER_NAME=opencv-$OPENCV_VER
OPEN_CV_CONTRIB_FOLDER_NAME=opencv_contrib-$OPENCV_VER

OPEN_CV_LINK=https://github.com/opencv/opencv/archive/$OPENCV_VER.zip
OPEN_CV_CONTRIB_LINK=https://github.com/opencv/opencv_contrib/archive/$OPENCV_VER.zip

OPEN_CV_FILE_NAME=$OPEN_CV_FOLDER_NAME.zip
OPEN_CV_CONTRIB_FILE_NAME=$OPEN_CV_CONTRIB_FOLDER_NAME.zip

CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release DOPENCV_EXTRA_MODULES_PATH=$PROJECT_DIR/$OPEN_CV_CONTRIB_FOLDER_NAME -DCMAKE_CXX_FLAGS=-D_FORCE_INLINES"

# pre-requierments
# compiler
sudo apt-get install build-essential
# required
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
# optional
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev


sudo rm -rf $PROJECT_DIR/$OPEN_CV_FOLDER_NAME
sudo rm -rf $PROJECT_DIR/$OPEN_CV_CONTRIB_FOLDER_NAME
cd ~/Downloads

wget -O $OPEN_CV_FILE_NAME $OPEN_CV_LINK
wget -O $OPEN_CV_CONTRIB_FILE_NAME $OPEN_CV_CONTRIB_LINK

mkdir -p $PROJECT_DIR

unzip $OPEN_CV_FILE_NAME -d $PROJECT_DIR
unzip $OPEN_CV_CONTRIB_FILE_NAME -d $PROJECT_DIR

rm -f ~/Downloads/$OPEN_CV_FILE_NAME
rm -f ~/Downloads/$OPEN_CV_CONTRIB_FILE_NAME

cd $PROJECT_DIR/
cd $OPEN_CV_FOLDER_NAME

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j7       
sudo make install -j7

