#!/bin/bash

MRBSP_WS=~/ANPL/code/mrbsp_ws

mkdir -p $MRBSP_WS/src
cd $MRBSP_WS
catkin init
cd src
git clone https://bitbucket.org/ANPL/mrbsp_ros
cd ..
catkin build

