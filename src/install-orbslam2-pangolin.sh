#!/bin/bash


PROJECT_DIR=~/ANPL/code/3rdparty
ANPL_PREFIX=/usr/ANPLprefix
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$ANPL_PREFIX -DCMAKE_BUILD_TYPE=Release"
FOLDER_NAME_PANGOLIN=pangolin
FOLDER_NAME_ORB_SLAM_2=orb-slam2
LINK_PANGOLIN=https://github.com/stevenlovegrove/Pangolin
LINK_ORB_SLAM_2=https://github.com/anpl-technion/orb-slam2.git
MAKE_FLAGS=-j7

# Install ORB SLAM2 and it's dependencies
# install opencv 3
# install-opencv3.sh

# install libglew (for pangolin)
sudo apt-get install libglew-dev -y


# install C++ logging library
sudo apt-get install libspdlog-dev

#delete old pangolin library
sudo rm -rf $PROJECT_DIR/$FOLDER_NAME_PANGOLIN

cd $PROJECT_DIR
git clone $LINK_PANGOLIN $FOLDER_NAME_PANGOLIN
cd $FOLDER_NAME_PANGOLIN
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make $MAKE_FLAGS
sudo make install $MAKE_FLAGS
