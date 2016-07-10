#!/bin/bash
PROJECT_DIR=~/ANPL/infrastructure/catkin_ws/src
PROJECT_NAME=tum_ardrone
SIMULATOR_NAME=tum_simulator

install-ros-ardrone-autonomy.sh

#from https://github.com/tum-vision/tum_ardrone
#from https://github.com/dougvk/tum_simulator

rm -rf ${PROJECT_DIR}/$PROJECT_NAME ${PROJECT_DIR}/$SIMULATOR_NAME
cd ${PROJECT_DIR}

git clone -b indigo-devel https://github.com/tum-vision/tum_ardrone.git
git clone -b indigo       https://github.com/talregev/tum_simulator
cd ..
rosdep install tum_ardrone -y
rosdep install --from-paths src --ignore-src --rosdistro indigo -y

catkin_make
