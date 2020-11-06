#!/bin/bash

#from http://wiki.ros.org/indigo/Installation/Ubuntu

#1.2 Setup sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# 1.3 Setup keys
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update

# Desktop-Full Install:
sudo apt-get install ros-melodic-desktop-full -y

# 1.5 Initialize rosdep
sudo rosdep init
rosdep update

# 1.6 Environment setup
echo "
source /opt/ros/melodic/setup.bash" >> ~/.bashrc

# 1.7 Getting rosinstall (python)
sudo apt-get install -y python-rosinstall python-rosinstall-generator python-wstool build-essential 

# 1.8 Relaunch bash for further usage
source ~/.bashrc
