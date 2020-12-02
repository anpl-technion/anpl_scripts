#!/bin/bash

PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/code/3rdparty
GTSAM_VER="4.0.2"
PROJECT_NAME=gtsam-$GTSAM_VER
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DGTSAM_BUILD_TESTS=OFF -DGTSAM_BUILD_EXAMPLES_ALWAYS=OFF -DGTSAM_BUILD_UNSTABLE=OFF -DCMAKE_BUILD_TYPE=Release"
GIT_LINK="https://github.com/borglab/gtsam.git"

echo "[INFO] Installing GTSAM make dependencies..."
sudo apt-get install g++ cmake -y
sudo apt-get install python-dev libbz2-dev libtbb-dev -y
sudo apt-get install libboost-all-dev libtbb-dev -y
echo "[INFO] Installing GTSAM 4.0.2 in progress..."
sudo rm -rf $PROJECT_DIR/gtsam-*
mkdir -p $PROJECT_DIR
cd $PROJECT_DIR
while [ ! -d "$PROJECT_DIR/$PROJECT_NAME" ]; do
      git clone $GIT_LINK $PROJECT_NAME --branch $GTSAM_VER
done
cd $PROJECT_DIR/$PROJECT_NAME

#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j4
sudo make install -j4
echo "export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
