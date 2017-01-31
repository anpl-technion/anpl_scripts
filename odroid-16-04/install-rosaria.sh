#!/bin/bash

CATKIN_WS=~/ANPL/infrastructur/catkin_ws
GIT_DIR=/rosaria
DEVEL=$CATKIN_WS/devel/setup.bash

#from http://wiki.ros.org/ROSARIA
#from http://wiki.ros.org/ROSARIA/Tutorials/How%20to%20use%20ROSARIA
#from https://github.com/amor-ros-pkg/rosaria

rm -rf $CATKIN_WS/src/$GIT_DIR
cd $CATKIN_WS/src
git clone https://github.com/amor-ros-pkg/rosaria.git

source $DEVEL
rosdep update
rosdep install rosaria -y

cd $CATKIN_WS
catkin_make
