#!/bin/bash

PROJECT_DIR=~/ANPL
WORKSPACE_NAME=ompl_ws

#from http://wiki.ros.org/catkin/Tutorials/create_a_workspace

# 2 Prerequisites
mkdir -p ${PROJECT_DIR}/$WORKSPACE_NAME/src
cd ${PROJECT_DIR}/$WORKSPACE_NAME/src
catkin_init_workspace

cd ${PROJECT_DIR}/$WORKSPACE_NAME/
catkin_make

echo "source ${PROJECT_DIR}/$WORKSPACE_NAME/devel/setup.bash" >> ~/.bashrc
source ${PROJECT_DIR}/$WORKSPACE_NAME/devel/setup.bash
