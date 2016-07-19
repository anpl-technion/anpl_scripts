#!/bin/bash

# from https://github.com/RIVeR-Lab/apriltags_ros

CATKIN_SRC_DIR=~/ANPL/infrastructure/catkin_ws/src
EIGEN_CONFIG_DIR=~/ANPL/code/cmake

cd $CATKIN_SRC_DIR

git clone https://github.com/RIVeR-Lab/apriltags_ros.git

cd ..

CMAKE_FLAGS="-DCMAKE_MODULE_PATH=$EIGEN_CONFIG_DIR"

catkin_make
