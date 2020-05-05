#!/bin/bash

source ~/.bashrc
TMP=0

if [ $ROS_DISTRO ="" ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 	echo "'${0##*/}' FAILED, ROS_DISTRO is empty"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	input -p "Enter manually ROS_DISTRO (example 'kinetic') : " ROS_DISTRO
fi

sudo apt-get install ros-$ROS_DISTRO-octomap* -y && wait $! && TMP=1
if [ $TMP -eq 1 ]; then
	echo "'${0##*/}' SUCCEED"
else
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 	echo "'${0##*/}' FAILED"
#	echo "   1) Fix Error"
#	echo "   2) Re-run script"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit
fi 
