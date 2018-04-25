#!/bin/bash

CATKIN_WS=~/ANPL/code/mrbsp_ws
TAB=/t

cd $CATKIN_WS/src
git clone https://github.com/ros-drivers/mocap_optitrack

# add line to fix multirobot issue
# from https://stackoverflow.com/questions/15157659/add-text-to-file-at-certain-line-in-linux?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
sed -i '155i 	seek(2);' mocap_optitrack/src/mocap_datapackets.cpp

# set multicast address
sed -i '17i multicast_address: 239.255.42.99' mocap_optitrack/config/mocap.yaml
sed -i '18d' mocap_optitrack/config/mocap.yaml

catkin build mocap_optitrack

