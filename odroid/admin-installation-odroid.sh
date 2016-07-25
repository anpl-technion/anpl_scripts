#!/bin/bash


# software
install-modules.sh
install-openssl-server.sh


# ros and drivers
od_install-ros.sh
setup-catkin_ws.sh
od_install-pointclouds.sh
od_install-octomap.sh
od_install-mavros.sh
od_install-csm.sh


# 3rd party code - also in user installation
od_install-gtsam.sh

