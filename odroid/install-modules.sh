#!/bin/bash

#from http://www.scipy.org/install.html
#from http://catkin-tools.readthedocs.org/en/latest/installing.html
#from http://stackoverflow.com/questions/12578499/how-to-install-boost-on-ubuntu
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -

sudo apt-get update
sudo apt-get install python-scipy python-catkin-tools cmake libboost-all-dev libtbb-dev vim zip libyaml-cpp-dev bash-completion -y
