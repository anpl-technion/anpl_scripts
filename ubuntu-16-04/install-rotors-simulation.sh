#!/bin/bash

CATKIN_WS_SRC=~/ANPL/infrastructure/catkin_ws/src

cd $CATKIN_WS_SRC

git clone https://github.com/ethz-asl/mav_comm.git
git clone --recursive https://github.com/ethz-asl/rotors_simulator

cd ..
catkin_make
