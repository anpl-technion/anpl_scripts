#!/bin/bash

CATKIN_SRC_DIR=~/ANPL/infrastructure/catkin_ws/src

cd $CATKIN_SRC_DIR

git clone https://bitbucket.org/ANPL/anpl_ros_infrastructur

mv anpl_ros_infrastructur anpl_inf

cd ..

catkin_make
