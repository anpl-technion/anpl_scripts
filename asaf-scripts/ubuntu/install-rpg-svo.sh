#!/bin/bash

CATKIN_SRC_DIR=~/ANPL/infrastructure/catkin_ws/src
DATA_DIR=~/ANPL/data

install-Sophus.sh
install-Fast.sh

cd $CATKIN_SRC_DIR
git clone https://github.com/uzh-rpg/rpg_vikit.git

sudo apt-get install ros-indigo-cmake-modules

git clone https://github.com/uzh-rpg/rpg_svo.git

cd ..
catkin_make

cd $DATA_DIR
mkdir -p bags/svo

cd bags/svo

wget rpg.ifi.uzh.ch/datasets/airground_rig_s3_2013-03-18_21-38-48.bag
