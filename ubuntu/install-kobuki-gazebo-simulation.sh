#!/bin/bash

catkin_ws=~/ANPL/catkin_ws
catkin_ws_srs=${catkin_ws}/src

sudo apt-get install pyqt4-dev-tools -y

rm -rf ${catkin_ws_srs}/kobuki
mkdir ${catkin_ws_srs}/kobuki
cd ${catkin_ws_srs}/kobuki

git clone -b indigo         https://github.com/yujinrobot/kobuki
git clone -b indigo         https://github.com/yujinrobot/kobuki_core
git clone -b indigo         https://github.com/yujinrobot/kobuki_desktop
git clone -b indigo         https://github.com/yujinrobot/kobuki_msgs
git clone -b indigo         http://github.com/yujinrobot/yujin_ocs
git clone                   https://github.com/ros/roslint
git clone -b indigo-devel   https://github.com/sniekum/ar_track_alvar_msgs
git clone -b indigo-devel   https://github.com/yujinrobot/yocs_msgs

cd catkin_ws
catkin_make
