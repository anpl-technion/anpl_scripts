#!/bin/bash

PROJECT_DIR=~/ANPL/infrastructur

#from http://wiki.ros.org/catkin/Tutorials/create_a_workspace

# 2 Prerequisites
mkdir -p ${PROJECT_DIR}/catkin_ws/src
cd ${PROJECT_DIR}/catkin_ws/src
catkin_init_workspace

cd ${PROJECT_DIR}/catkin_ws/
catkin_make

echo "source ${PROJECT_DIR}/catkin_ws/devel/setup.bash" >> ~/.bashrc
