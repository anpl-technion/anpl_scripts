#!/bin/bash

# software
install-modules.sh
open-in-terminal.sh
install-java-jdk.sh
install-GVim.sh
install-lyx.sh
install-openssl-server.sh


# programs
install-smartgit.sh # also in user installation
#install-qgroundcontrol.sh
#install-jsoncpp.sh


# ros and drivers
install-ros.sh
setup-catkin_ws.sh # also in user installation
install-pointclouds.sh


# 3rd party code - also in user installation
install-gtsam.sh
install-planar-icp.sh
install-vlfeat.sh
install-OMPL.sh


# code projects - also in user installation
clone-common-computation.sh
clone-cmakes.sh
clone-icp-laser.sh
clone-mr-icp-laser.sh


# infrastructur code - also in user installation
install-turtlebot-gazebo-simulation.sh # only in admin installation
install-pioner-gazebo-simulation.sh
install-tum-ardrone.sh
clone-anpl-ros-infrastructure.sh
install-apriltags.sh
install-multirobot.sh
