#!/bin/bash

CATKIN_WS=~/ANPL/catkin_ws
GIT_DIR=/realsense_camera

#from https://github.com/BlazingForests/realsense_camera
#from http://wiki.ros.org/realsense_camera
#from http://milq.github.io/install-opencv-ubuntu-debian/
#from http://answers.ros.org/question/199799/configuration-of-pcl-with-cmake/

sudo apt-get install libudev-dev libopencv-dev python-opencv ros-indigo-pcl-ros -y

rm -rf $CATKIN_WS/src/$GIT_DIR
cd $CATKIN_WS/src
git clone https://github.com/BlazingForests/realsense_camera

cd $CATKIN_WS
catkin_make
