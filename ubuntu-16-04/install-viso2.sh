#!/bin/bash

CATKIN_WS_SRC=~/ANPL/infrastructure/catkin_ws/src

cd $CATKIN_WS_SRC

git clone https://github.com/srv/viso2

cd ..
catkin_make
