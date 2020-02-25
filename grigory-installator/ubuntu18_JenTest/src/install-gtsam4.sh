#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
GTSAM_VER="4+"
PROJECT_NAME=gtsam-$GTSAM_VER
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DGTSAM_BUILD_TESTS=OFF -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF -DGTSAM_BUILD_UNSTABLE=OFF -DCMAKE_BUILD_TYPE=Release"
GIT_LINK="https://bitbucket.org/gtborg/gtsam.git"

sudo apt-get install libboost-all-dev libtbb-dev -y
sudo rm -rf $PROJECT_DIR/gtsam-*
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR
while [ ! -d "$PROJECT_DIR/$PROJECT_NAME" ]; do
      git clone $GIT_LINK $PROJECT_NAME
done
cd $PROJECT_DIR/$PROJECT_NAME

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j4
sudo make install -j4
echo "export LD_LIBRARY_PATH=/usr/ANPLprefix/lib:$LD_LIBRARY_PATH" >> ~/.bashrc



