#!/bin/bash


read -p "Choose which infrastructure you want: 1-(anpl_mrbsp) or 2-(mrbsp_ros) " NUM
case $NUM in
	[1]* ) PROJECT_NAME=anpl_mrbsp;;
        [2]* ) PROJECT_NAME=mrbsp_ros;;
        * ) echo "Please answer 1 or 2. Rerun sutup-anpl-mrbsp.sh"
	exit ;;
esac

WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME
WS_SRC=$WS_PATH/src
PREFIX=/usr/ANPLprefix

#from http://wiki.ros.org/catkin/Tutorials/create_a_workspace

# 2 Prerequisitesoos
sudo rm -rf $WS_PATH


mkdir -p $WS_PATH/src && cd $WS_PATH
source /opt/ros/$ROS_DISTRO/setup.bash
catkin init
catkin build && wait $!

cd $WS_SRC

if [ ! -d "$WS_SRC/pioneer_keyop" ]; then
  git clone https://bitbucket.org/ANPL/pioneer_keyop
fi
if [ ! -d "$WS_SRC/$PROJECT_NAME" ]; then
  git clone https://bitbucket.org/ANPL/$PROJECT_NAME.git $WS_SRC/$PROJECT_NAME
fi


echo "source $WS_PATH/devel/setup.bash" >> ~/.bashrc
source $WS_PATH/devel/setup.bash
