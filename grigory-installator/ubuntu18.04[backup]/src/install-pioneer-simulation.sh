#!/bin/bash

CATKIN_WS_SRC=~/ANPL/infrastructure/catkin_ws/src

cd $CATKIN_WS_SRC
pwd
# download pioneer desccription repo
git clone https://github.com/MobileRobots/amr-ros-config

# download pioneer keyboard controller repo
git clone https://bitbucket.org/ANPL/pioneer_keyop

cd ..
catkin_make
