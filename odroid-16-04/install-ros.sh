#!/bin/bash
#from here: http://wiki.ros.org/indigo/Installation/UbuntuARM

#2.2 Set your Locale
sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX

#2.3 Setup your sources.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

#2.4 Set up your keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

#2.5 Installation
sudo apt-get update
sudo apt-get install ros-kinetic-ros-base -y

#2.6 Initialize rosdep
sudo apt-get install python-rosdep -y
sudo rosdep init
rosdep update

#2.7 Environment setup
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

#2.8 Getting rosinstall
sudo apt-get install python-rosinstall -y


