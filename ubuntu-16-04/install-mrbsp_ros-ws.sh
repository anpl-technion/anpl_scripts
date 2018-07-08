#!/bin/bash

PROJECT_NAME=mrbsp_ros
WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME
PREFIX=/usr/ANPLprefix

#remove old mrbsp_ros workspace
sudo rm -rf $WS_PATH

mkdir -p $WS_PATH/src && cd $WS_PATH
catkin init
catkin build

source $WS_PATH/devel/setup.bash
echo "source $WS_PATH/devel/setup.bash" >> ~/.bashrc

cd $WS_PATH/src
git clone https://bitbucket.org/ANPL/pioneer_keyop
git clone https://bitbucket.org/ANPL/anpl_ros_infrastructur anpl_inf
git clone https://bitbucket.org/ANPL/mrbsp_ros
git clone https://github.com/MobileRobots/amr-ros-config

#copy cmake files that node will find anpl libs.
cd $WS_PATH/src/mrbsp_ros/mrbsp_ros_utils/scripts/
sudo sh install-find-cmakes.sh
sudo sh install-diverce-short-path.sh


cd $WS_PATH
catkin build





