#!/bin/bash

CATKIN_WS=~/ANPL/infrastructure/catkin_ws
FOLDER_NAME=pointmatcher-ros
LINK=https://github.com/ethz-asl/pointmatcher-ros


sudo rm -rf $CATKIN_WS/src/$FOLDER_NAME

cd $CATKIN_WS/src/
git clone $LINK $FOLDER_NAME
cd $CATKIN_WS
catkin_make
