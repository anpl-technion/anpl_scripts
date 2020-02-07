#!/bin/bash

CATKIN_WS=~/ANPL/infrastructure/mrbsp_ws
MAV_DIR=mav_comm
ROTOR_DIR=rotors_simulator

rm -rf $CATKIN_WS/src/$MAV_DIR
rm -rf $CATKIN_WS/src/$ROTOR_DIR

sudo apt-get install autoconf -y
sudo apt-get install protobuf-compiler -y
sudo apt-get install libgoogle-glog-dev -y


cd $CATKIN_WS/src

git clone https://github.com/ethz-asl/mav_comm.git $MAV_DIR
# rotors_gazebo_plugins often gets updates, which might be unstable.
# Replacing with last actually working commit to the day 18.12.2019.
# might be deleted with stable release of rotors_simulator.
cd $MAV_DIR && git checkout .
git checkout 5b16cb2274f7c53ad6f60b1069369f24af0fda3b && cd ..

git clone --recursive https://github.com/ethz-asl/rotors_simulator.git $ROTOR_DIR
cd $ROTOR_DIR && git checkout .
git reset --hard ac77a8a && cd ..


#delete rotors_hil_interface because we didn't figure out yet how to compile it. 
cd $CATKIN_WS/src/$ROTOR_DIR
rm -rf rotors_hil_interface/


#cd $CATKIN_WS/
#catkin build -DBUILD_OCTOMAP_PLUGIN=TRUE
