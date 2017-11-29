#!/bin/bash

CATKIN_WS=~/ANPL/infrastructure/catkin_ws

cd $CATKIN_WS/src
git clone https://bitbucket.org/ANPL/anpl_ros_infrastructur anpl_inf
cd ..
catkin_make

