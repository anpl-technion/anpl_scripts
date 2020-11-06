#!/bin/bash
sudo apt-get update

TMP=0
sudo apt-get install ros-$ROS_DISTRO-mavros* -y && wait $! && TMP=1
sudo apt-get install ros-$ROS_DISTRO-mavlink -y && wait $! && TMP=1
sudo apt-get install ros-$ROS_DISTRO-mav-* -y && wait $! && TMP=1

if [ $TMP -eq 1 ]; then
	echo "'${0##*/}' SUCCEED"
else
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 	echo "'${0##*/}' FAILED"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit
fi 

