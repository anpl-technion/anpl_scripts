#!/bin/bash

CATKIN_WS=~/ANPL/infrastructure/mrbsp_ws
FOLDER_NAME=rosaria
DEVEL=$CATKIN_WS/devel/setup.bash
LINK=https://github.com/amor-ros-pkg/rosaria.git

#from http://wiki.ros.org/ROSARIA
#from http://wiki.ros.org/ROSARIA/Tutorials/How%20to%20use%20ROSARIA
#from https://github.com/amor-ros-pkg/rosaria

source ~/.bashrc

rm -rf $CATKIN_WS/src/$FOLDER_NAME
cd $CATKIN_WS/src
git clone $LINK $FOLDER_NAME
sed -ie '/^#set(ROS_BUILD_TYPE RelWithDebInfo)/a add_compile_options(-std=c++11)' $FOLDER_NAME/CMakeLists.txt

source $DEVEL
sudo apt-get install libaria-dev -y

cd $CATKIN_WS
catkin build rosaria

rosdep update
echo $ROS_PACKAGE_PATH
rosdep install rosaria -y
