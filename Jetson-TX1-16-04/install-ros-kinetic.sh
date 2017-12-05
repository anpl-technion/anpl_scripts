#!/bin/bash

#from http://wiki.ros.org/indigo/Installation/Ubuntu

#1.2 Setup sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# 1.3 Setup keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# 1.4 Installation
sudo apt-get update

# ROS-Base Install:
sudo apt-get install ros-kinetic-ros-base -y

# 1.5 Initialize rosdep
sudo rosdep init
rosdep update

# 1.6 Environment setup
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source /opt/ros/kinetic/setup.bash

# 1.7 Getting rosinstall (python)
sudo apt-get install python-rosinstall -y
