#!/bin/bash

PROJECT_NAME=anpl_mrbsp
WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME
WS_SRC=$WS_PATH/src
PREFIX=/usr/ANPLprefix

#from http://wiki.ros.org/catkin/Tutorials/create_a_workspace

# 2 Prerequisitesoos
sudo rm -rf $WS_PATH

source ~/.bashrc
mkdir -p $WS_PATH/src && cd $WS_PATH
source /opt/ros/$ROS_DISTRO/setup.bash
sudo rm -f .catkin_tools
catkin init
catkin build -j4 && wait $!

cd $WS_SRC
read -p "Which GTSAM version do you need?[3 or 4]" GTSAM_VER
case $GTSAM_VER in
        [3] ) BRANCH_NAME=master;;
        [4] ) BRANCH_NAME=gtsam4;;
        * ) echo "Please answer 3 or 4 and not $GTSAM_VER."
	exit;;
    esac

if [ ! -d "$WS_SRC/pioneer_keyop" ]; then
  git clone https://bitbucket.org/ANPL/pioneer_keyop
fi
if [ ! -d "$WS_SRC/$PROJECT_NAME" ]; then
  git clone -b $BRANCH_NAME https://bitbucket.org/ANPL/$PROJECT_NAME.git $WS_SRC/$PROJECT_NAME
fi


echo "source $WS_PATH/devel/setup.bash" >> ~/.bashrc
source $WS_PATH/devel/setup.bash
