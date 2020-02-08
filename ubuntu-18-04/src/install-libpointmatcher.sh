#!/bin/bash

PREFIX=/usr/
PROJECT_DIR=~/ANPL/code/3rdparty
LIBPOINTMATCHER_VER=1.2.3
FOLDER_NAME=libpointmatcher-$LIBPOINTMATCHER_VER

LINK=https://github.com/ethz-asl/libpointmatcher
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXE_LINKER_FLAGS=-fopenmp"

sudo rm -rf $PROJECT_DIR/$FOLDER_NAME

mkdir -p $PROJECT_DIR
cd $PROJECT_DIR
git clone $LINK $FOLDER_NAME
cd $PROJECT_DIR/$FOLDER_NAME
mkdir build && cd build
cmake $CMAKE_FLAGS ..
make -j7
sudo make install -j7
