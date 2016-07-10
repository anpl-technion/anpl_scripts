#!/bin/bash

CATKIN_DIR=~/ANPL/infrastructure/catkin_ws

rm -rf $CATKIN_DIR/src/p3atGazeboRos
cd $CATKIN_DIR/src/
git clone https://github.com/balakumar-s/p3atGazeboRos

git clone https://bitbucket.org/ANPL/pioneer_keyop

cd ..
catkin_make
