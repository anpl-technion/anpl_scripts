#!/bin/bash

#from https://github.com/mavlink/mavlink
#from http://qgroundcontrol.org/mavlink/packaging

PROJECT_DIR=~/ANPL/MAV/
sudo apt-get install cmake
rm -rf $PROJECT_DIR/mavlink
mkdir -p $PROJECT_DIR 
cd $PROJECT_DIR
git clone git://github.com/mavlink/mavlink.git
cd mavlink
mkdir -p build
cd build && cmake ..
