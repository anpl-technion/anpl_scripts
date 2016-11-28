#!/bin/bash

THIRD_PARTY_DIR=~/ANPL/code/3rdparty


cd $THIRD_PARTY_DIR

git clone https://github.com/strasdat/Sophus.git
cd Sophus
git checkout a621ff
mkdir build
cd build
cmake ..
make
