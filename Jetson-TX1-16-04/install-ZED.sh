#!/bin/bash

ZED_SDK_VER=2.2.1
SDK_FILENAME=ZED_SDK_Linux_JTX1_v$ZED_SDK_VER.run
ROS_WRAPPER_VER=2.1.x
ROS_WRAPPER_FILENAME=v$ROS_WRAPPER_VER.tar.gz
DOWNLOADS_FOLDER=~/Downloads
CATKIN_WS_FOLDER=~/ANPL/infrastructure/catkin_build_ws

# Install PCL
sudo apt-get install libpcl1 ros-kinetic-pcl* -y

# ZED SDK
cd $DOWNLOADS_FOLDER
wget https://cdn.stereolabs.com/developers/downloads/$SDK_FILENAME
chmod +x $SDK_FILENAME

./$SDK_FILENAME

# install ros package dependencies
sudo apt-get install ros-kinetic-tf2-geometry-msgs ros-kinetic-tf2-geometry-msgs

# ZED ROS wrapper
cd $CATKIN_WS_FOLDER/src
wget https://github.com/stereolabs/zed-ros-wrapper/archive/$ROS_WRAPPER_FILENAME
tar zxf $ROS_WRAPPER_FILENAME
mv zed-ros-wrapper-$ROS_WRAPPER_VER zed_ros_wrapper
rm $ROS_WRAPPER_FILENAME

cd ..
catkin build
