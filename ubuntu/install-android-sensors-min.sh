#!/bin/bash

PROJECT_DIR=~/ANPL
rm -rf $PROJECT_DIR/android
mkdir -p $PROJECT_DIR/android/src
cd $PROJECT_DIR/android/src

git clone -b indigo https://github.com/rosjava/rosjava_build_tools.git
git clone -b indigo https://github.com/rosjava/rosjava_bootstrap.git
git clone https://github.com/talregev/Sensors.git

cd $PROJECT_DIR/android
export ROS_MAVEN_DEPLOYMENT_REPOSITORY=/home/tal/ANPL/android/devel/share/maven
catkin_make
