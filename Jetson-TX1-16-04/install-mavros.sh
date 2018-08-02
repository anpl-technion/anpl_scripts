#!/bin/bash

sudo apt-get update

sudo apt-get install ros-$ROS_DISTRO-mavros* -y
sudo apt-get install ros-$ROS_DISTRO-mavlink -y
sudo apt-get install ros-$ROS_DISTRO-mav-* -y
