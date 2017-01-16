#!/bin/bash

PROJECT_DIR=~/ANPL/code/3rdparty
PREFIX=~/prefix
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"

cd $PROJECT_DIR

git clone https://bitbucket.org/ANPL/planar_icp

cd planar_icp

mkdir -p build-release
cd build-release
cmake $CMAKE_FLAGS ..
sudo make install
