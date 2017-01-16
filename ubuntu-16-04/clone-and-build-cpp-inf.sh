#!/bin/bash

PROJECT_DIR=~/ANPL/infrastructure
FOLDER_NAME=cpp

cd $PROJECT_DIR
rm -rf $FOLDER_NAME

git clone https://bitbucket.org/ANPL/anpl_infrastructur_cpp $FOLDER_NAME -b devel

cd $FOLDER_NAME/robots

mkdir build && cd build

cmake ..
make -j7
