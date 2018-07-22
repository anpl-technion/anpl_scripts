#!/bin/bash

CATKIN_WS=~/ANPL/infrastructure/mrbsp_ws
MAV_DIR=mav_comm
ROTOR_DIR=rotors_simulator

rm -rf $CATKIN_WS/src/$MAV_DIR
rm -rf $CATKIN_WS/src/$ROTOR_DIR

sudo apt-get install autoconf -y
sudo apt install protobuf-compiler -y
sudo apt install libgoogle-glog-dev -y


cd $CATKIN_WS/src

git clone https://github.com/ethz-asl/mav_comm.git $MAV_DIR
git clone --recursive https://github.com/ethz-asl/rotors_simulator.git $ROTOR_DIR

#delete rotors_hil_interface because we didn't figure yet how to compile it. 
cd $CATKIN_WS/src/$ROTOR_DIR
rm -rf rotors_hil_interface/


cd $CATKIN_WS/
catkin build -DBUILD_OCTOMAP_PLUGIN=TRUE
