#!/bin/bash

PROJECT_DIR=~/ANPL
rm -rf $PROJECT_DIR/apps
mkdir -p $PROJECT_DIR/apps/src
cd $PROJECT_DIR/apps/src

git clone -b indigo https://github.com/rosjava/rosjava_build_tools.git
git clone -b indigo https://github.com/rosjava/rosjava_bootstrap.git
git clone -b 	    https://github.com/ros-geographic-info/unique_identifier.git
git clone -b indigo https://github.com/robotics-in-concert/rocon_msgs.git
git clone -b hydro  https://github.com/rosjava/rosjava_messages.git
git clone -b indigo https://github.com/robotics-in-concert/rocon_rosjava_core.git
git clone -b indigo https://github.com/rosjava/android_remocons.git
git clone -b indigo https://github.com/rosjava/android_apps.git

cd $PROJECT_DIR/apps
catkin_make
