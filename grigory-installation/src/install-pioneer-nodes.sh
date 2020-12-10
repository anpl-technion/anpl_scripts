#!/bin/bash
WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME
WS_SRC=$WS_PATH/src
PREFIX=/usr/ANPLprefix
SCRIPTS_DIR=~/ANPL/scripts/grigory-scripts/installation/src


# Argument read.
# Script gets 2 arguments strictly.
# Mandatory arguments:
#	-i=<inf name>, --infrastructure=<inf name>
#	-b=<branch name>, --branch=<branch name>
RED='\033[0;31m'
NC='\033[0m' # No Color
if [ "$#" -gt  "1" ]; then
	echo -e "${RED}ERROR at '${0##*/}': ${NC}\nArguments are not provided. Please rerun script with 1 arguments: -i=<infrastructure name> "
	exit 0 
elif [ "$#" -eq  "0" ]; then
	PROJECT_NAME=$(ls $WS_SRC | grep mrbsp)
	case $PROJECT_NAME in 
		mrbsp_ros ) ;;
		anpl_mrbsp ) ;;
		*) echo -e "${RED} Could not determinate project name, please rerun script providing it as argument: -i=<mrbsp_ros | anpl_mrbsp>${NC}";;
	esac
else
	for i in "$@"; do
	case $i in
		-i=*|--infrastructure=*)
			PROJECT_NAME="${i#*=}" && shift # past argument=value
		;;
	    *)
			echo -e "${RED}ERROR at '${0##*/}': ${NC}\n${i}: Unknown argument provided. Please rerun script with 1 arguments: -i=<infrastructure name> "
			exit
		;;
	esac
	done
fi


cd $WS_SRC

while [ ! -d "$WS_SRC/pioneer_keyop" ]; do
  git clone https://bitbucket.org/ANPL/pioneer_keyop
done

while [ ! -d "$WS_SRC/amr-ros-config" ]; do 
  git clone https://github.com/MobileRobots/amr-ros-config
done

bash $SCRIPTS_DIR/install-rosaria.sh
