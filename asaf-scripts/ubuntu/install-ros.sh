#!/bin/bash

#from http://wiki.ros.org/indigo/Installation/Ubuntu

#1.2 Setup sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'

# 1.3 Setup keys
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

# 1.4 Installation
sudo apt-get update

#If you are using Ubuntu Trusty 14.04.2 and experience dependency issues during the ROS installation, you may have to install some additional system dependencies.
#/!\ Do not install these packages if you are using 14.04, it will destroy your X server:
#sudo apt-get install xserver-xorg-dev-lts-utopic mesa-common-dev-lts-utopic libxatracker-dev-lts-utopic libopenvg1-mesa-dev-lts-utopic libgles2-mesa-dev-lts-utopic libgles1-mesa-dev-lts-utopic libgl1-mesa-dev-lts-utopic libgbm-dev-lts-utopic libegl1-mesa-dev-lts-utopic -y
sudo apt-get install libgl1-mesa-dev-lts-utopic -y

# Desktop-Full Install:
sudo apt-get install ros-indigo-desktop-full -y

# 1.5 Initialize rosdep
sudo rosdep init
rosdep update

# 1.6 Environment setup
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source /opt/ros/indigo/setup.bash

# 1.7 Getting rosinstall (python)
sudo apt-get install python-rosinstall -y
