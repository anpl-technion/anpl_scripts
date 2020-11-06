#!/bin/bash

CATKIN_WS=~/ANPL/infrastructure/mrbsp_ws

#remove old optitrack
rm -rf  $CATKIN_WS/src/mocap_optitrack

#install new optitrack
cd $CATKIN_WS/src
git clone https://github.com/ros-drivers/mocap_optitrack

# add line to fix multirobot issue
# from https://stackoverflow.com/questions/15157659/add-text-to-file-at-certain-line-in-linux?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
sed -i '155i\    seek(2);' mocap_optitrack/src/mocap_datapackets.cpp

# set multicast address
# https://unix.stackexchange.com/questions/75803/writing-starting-from-a-certain-line-number-in-a-text-file
#https://stackoverflow.com/questions/11145270/how-to-replace-an-entire-line-in-a-text-file-by-line-number/11145362
sed -i '17s/.*/        multicast_address: 239.255.42.99/' mocap_optitrack/config/mocap.yaml

catkin build mocap_optitrack

