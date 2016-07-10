#!/bin/bash

CATKIN_SRC_DIR=~/ANPL/infrastructure/catkin_ws/src

cd $CATKIN_SRC_DIR

git clone https://bitbucket.org/ANPL/multirobot

cd ..

catkin_make
