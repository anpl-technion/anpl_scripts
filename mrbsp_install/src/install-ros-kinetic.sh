#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color
case $# in
	0) ROS_PACKAGE=desktop-full;;
	1) case $1 in
		desktop-full)
			ROS_PACKAGE=$1;;
		desktop)
			ROS_PACKAGE=$1;;
		*) echo -e "${RED}ERROR at '${0##*/}': ${NC}\n$1: Unknown ROS package provided, please rerun."
		   exit;;
	   esac ;;
	*) echo -e "${RED}ERROR at '${0##*/}': ${NC}\nToo many arguments provided, please rerun."
	   exit;;
esac

#from http://wiki.ros.org/indigo/Installation/Ubuntu

#1.2 Setup sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# 1.3 Setup keys
# sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update

# Desktop-Full Install:
sudo apt-get install ros-kinetic-$ROS_PACKAGE -y

# 1.5 Initialize rosdep
sudo rosdep init
rosdep update

# 1.6 Environment setup
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source /opt/ros/kinetic/setup.bash

# 1.7 Getting rosinstall (python)
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y

# 1.8 Relaunch bash for further usage
. ~/.bashrc
. ~/.profile