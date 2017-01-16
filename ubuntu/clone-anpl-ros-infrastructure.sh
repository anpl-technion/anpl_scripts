#!/bin/bash

CATKIN_SRC_DIR=~/ANPL/infrastructure/catkin_ws/src
PROJECT=anpl_inf

cd $CATKIN_SRC_DIR

rm -rf $PROJECT

git clone https://bitbucket.org/ANPL/anpl_ros_infrastructur $PROJECT

cd ..

catkin_make

cp -a src/anpl_inf/gazebo_models/apriltags/. ~/.gazebo/models/
