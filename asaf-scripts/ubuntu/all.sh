#!/bin/bash

##setup envirement
./setup-ubuntu-env.sh
install-dos2unix.sh
setup-scripts-env.sh

##install softwares
install-git.sh
install-modules.sh
open-in-terminal.sh
install-java-jdk.sh
install-GVim.sh
install-lyx.sh
install-smartgit.sh
install-openssl-server.sh
install-pointclouds.sh

install-gtsam.sh
install-planarICP.sh
install-vlfeat.sh
#install-OMPL.sh # add flag from git or from zip see gtsam script
#clone-mrIcpLaser.sh

install-ros.sh
setup-catkin_ws.sh

#install robot package for gazebo
install-turtlebot-gazebo-simulation.sh
install-pioner-gazebo-simulation.sh
install-tum-ardrone.sh

# TODO: set keyop controllers



#setup-git-folder-in-catkin-ws.sh
#setup-git-folder-in-project-dir.sh
#install-rosjava-env.sh

#reload .bashrc
bash
