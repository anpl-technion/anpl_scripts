#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
FOLDER_NAME_PANGOLIN=pangolin
FOLDER_NAME_ORB_SLAM_2=orb-slam2
LINK_PANGOLIN=https://github.com/stevenlovegrove/Pangolin
LINK_ORB_SLAM_2=https://github.com/raulmur/ORB_SLAM2
MAKE_FLAGS=-j7

# Install ORB SLAM2 and it's dependencies
# install libglew (for pangolin)
sudo apt-get install libglew-dev -y

#delete old pangolin library
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME_PANGOLIN

cd $PROJECT_DIR
git clone $LINK_PANGOLIN $FOLDER_NAME_PANGOLIN
cd $FOLDER_NAME_PANGOLIN
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS
sudo make install $MAKE_FLAGS


#delete old orb-slam2 library
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME_ORB_SLAM_2

cd $PROJECT_DIR
git clone $LINK_ORB_SLAM_2 $FOLDER_NAME_ORB_SLAM_2
cd $FOLDER_NAME_ORB_SLAM_2
cd Thirdparty/DBoW2
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS

echo "Configuring and building Thirdparty/g2o ..."
cd ../../g2o
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS


echo "Uncompress vocabulary ..."
cd ../../../Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

echo "Configuring and building ORB_SLAM2 ..."

mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS
