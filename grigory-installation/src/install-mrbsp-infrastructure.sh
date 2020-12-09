#!/bin/bash
WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME
WS_SRC=$WS_PATH/src
PREFIX=/usr/ANPLprefix



# Argument read.
# Script gets 2 arguments strictly.
# Mandatory arguments:
#	-i=<inf name>, --infrastructure=<inf name>
#	-b=<branch name>, --branch=<branch name>
RED='\033[0;31m'
NC='\033[0m' # No Color
if [ "$#" -ne  "2" ]; then
	echo -e "${RED}ERROR at '${0##*/}': ${NC}\nArguments are not provided. Please rerun script with 2 arguments: -i=<infrastructure name> -b=<branch name>"
	exit 0 
else
	for i in "$@"; do
	case $i in
		-i=*|--infrastructure=*)
			PROJECT_NAME="${i#*=}" && shift # past argument=value
		;;
	    -b=*|--branch=*)
		    BRANCH="${i#*=}" && shift # past argument=value
	    ;;
	    *)
			echo -e "${RED}ERROR at '${0##*/}': ${NC}\n${i}: Unknown argument provided. Please rerun script with 2 arguments: -i=<infrastructure name> -b=<branch name>"
			exit
		;;
	esac
	done
fi

#from http://wiki.ros.org/catkin/Tutorials/create_a_workspace
# 2 Prerequisitesoos
sudo rm -rf $WS_PATH

source /opt/ros/$ROS_DISTRO/setup.bash
mkdir -p $WS_PATH/src && cd $WS_PATH
catkin init
catkin build
source devel/source.bash
echo $ROS_PACKAGE_PATH

cd $WS_SRC

if [ ! -d "$WS_SRC/$PROJECT_NAME" ]; then
  git clone -b $BRANCH https://bitbucket.org/ANPL/$PROJECT_NAME.git $WS_SRC/$PROJECT_NAME 
fi 

if [ ! -d "$WS_SRC/anpl_inf" ]; then 
  git clone https://bitbucket.org/ANPL/anpl_ros_infrastructur anpl_inf
fi

echo "source $WS_PATH/devel/setup.bash" >> ~/.bashrc
source $WS_PATH/devel/setup.bash
