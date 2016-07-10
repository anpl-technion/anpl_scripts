#!/bin/bash

PREFIX=~/prefix
PROJECT_DIR=~/ANPL
INSTALL_DIR=$PROJECT_DIR/flann-1.8.4-src

# Prerequisites:
# sudo apt-get install cmake
# pip install numpy

# GTest - not mandatory:
GTEST_DIR=/usr/include/gtest
if [ ! -d "$GTEST_DIR" ]; then
cd $PROJECT_DIR
wget http://googletest.googlecode.com/files/gtest-1.7.0.zip
unzip gtest-1.7.0.zip
rm gtest-1.7.0.zip
cd gtest-1.7.0
./configure
make
sudo cp -a include/gtest /usr/include
sudo cp -a lib/.libs/* /usr/lib/
sudo ldconfig -v | grep gtest
fi
# OpenMpi - mandatory for parallel computation
sudo apt-get install openmpi* -y --force-yes


rm -rf $PROJECT_DIR/flann-1.8.4-src
cd $PROJECT_DIR
wget http://www.cs.ubc.ca/research/flann/uploads/FLANN/flann-1.8.4-src.zip
unzip flann-1.8.4-src.zip
rm flann-1.8.4-src.zip

cd flann-1.8.4-src
mkdir build
cd build
cmake ..
make
sudo make install

