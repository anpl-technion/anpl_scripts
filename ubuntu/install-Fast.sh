#!/bin/bash

THIRD_PARTY_DIR=~/ANPL/code/3rdparty


cd $THIRD_PARTY_DIR

git clone https://github.com/uzh-rpg/fast.git
cd fast
mkdir build
cd build
cmake ..
make
