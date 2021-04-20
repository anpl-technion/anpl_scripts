#!/bin/bash

cd ~/ANPL/infrastructure/mrbsp_ws/src/rosaria 
sed -ie '/^#set(ROS_BUILD_TYPE RelWithDebInfo)/a add_compile_options(-std=c++11)' CMakeLists.txt
catkin build rosaria