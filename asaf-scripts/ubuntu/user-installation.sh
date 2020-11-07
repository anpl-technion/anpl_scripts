#!/bin/bash

# programs
install-smartgit.sh # also in user installation
#install-qgroundcontrol.sh
#install-jsoncpp.sh


# ros enviroment
set-ros-enviroment.sh
setup-catkin_ws.sh


# 3rd party code - also in user installation
install-gtsam.sh
install-planar-icp.sh
install-vlfeat.sh


# code projects - also in user installation
clone-common-computation.sh
clone-cmakes.sh
clone-icp-laser.sh
clone-mr-icp-laser.sh


# infrastructur code - also in user installation
install-pioner-gazebo-simulation.sh
install-tum-ardrone.sh
clone-anpl-ros-infrastructure.sh
install-apriltags.sh
install-multirobot.sh

clone-and-build-cpp-inf.sh
clone-matlab-inf.sh