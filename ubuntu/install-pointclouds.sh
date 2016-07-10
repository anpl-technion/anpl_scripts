#!/bin/bash

sudo add-apt-repository ppa:v-launchpad-jochen-sprickerhof-de/pcl
sudo apt-get update
sudo apt-get install libpcl-all -y
sudo apt-get install ros-indigo-pcl-conversions -y
