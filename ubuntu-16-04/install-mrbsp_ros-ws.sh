#!/bin/bash

CATKIN_WS_NAME=mrbsp_ws
PATH_TO_WS=~/ANPL/code/$CATKIN_WS_NAME

sudo apt-get install python-catkin-tools -y

cd
mkdir -p $PATH_TO_WS/src && cd $PATH_TO_WS
catkin build
echo "source $PATH_TO_WS/devel/setup.bash" >> ~/.bashrc
source $PATH_TO_WS/devel/setup.bash

cd src
git clone https://bitbucket.org/ANPL/mrbsp_ros
git clone https://bitbucket.org/ANPL/anpl_ros_infrastructur anpl_inf
git clone https://github.com/MobileRobots/amr-ros-config
git clone https://bitbucket.org/ANPL/pioneer_keyop

cd mrbsp_ros/mrbs_ros_utils/scripts
sudo sh install-find-cmakes.sh
sudo sh install-diverce-short-path.sh

sudo apt-get install ros-kinetic-ecl -y
sudo apt-get install ros-kinetic-rviz-visual-tools -y

cd $PATH_TO_WS
catkin build



