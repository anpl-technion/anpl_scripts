#!/bin/bash

#libaries update:
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get upgrade
#dangrouse command. it will upgrade ubuntu unwilling.
#sudo apt-get dist-upgrade

echo "in RVIZ: change Fixed frame to: realsense_frame"
