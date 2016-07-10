#!/bin/bash

CATKIN_SRC_DIR=~/ANPL/infrastructure/catkin_ws/src

cd $CATKIN_SRC_DIR

rm -rf anpl_inf

git clone https://bitbucket.org/ANPL/anpl_ros_infrastructur

mv anpl_ros_infrastructur anpl_inf

cd ..

catkin_make

cp -a src/anpl_inf/gazebo_models/apriltags/. ~/.gazebo/models/
