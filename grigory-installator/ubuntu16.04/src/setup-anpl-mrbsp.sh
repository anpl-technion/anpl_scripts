#!/bin/bash

echo -e "\033[0;42m Choosing Infrastructure \033[0m"
read -p "Choose which infrastructure you want: 
	1 - (anpl_mrbsp[NEW])
	2 - (mrbsp_ros[OLD]):    " NUM
echo
case $NUM in
	[1]* ) PROJECT_NAME=anpl_mrbsp
		echo -e "\033[0;42m Choosing Branch \033[0m"
		read -p "Choose which branch you want:
         		1 - (master[Lidar-gtsam3])
		 	2 - (gtsam4[Lidar-gtsam4]):   " NUM
		echo
		case $NUM in
			[1]* ) BRANCH=master;;
        		[2]* ) BRANCH=gtsam4;;
       			* ) echo "Please answer 1 or 2. Rerun setup-anpl-mrbsp.sh"
			exit ;;
		esac;;
        [2]* ) PROJECT_NAME=mrbsp_ros
		echo -e "\033[0;42m Choosing Branch \033[0m"
		read -p "Choose which branch you want:
         		1 - (t-bsp-julia[Lidar])
		 	2 - (or-vi_project[ORB-vsion]):   " NUM
		echo
		case $NUM in
			[1]* ) BRANCH=t-bsp-julia;;
        		[2]* ) BRANCH=or-vi_project;;
       			* ) echo "Please answer 1 or 2. Rerun setup-anpl-mrbsp.sh"
			exit ;;
		esac;;
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
TMP=0
if [ ! -d "$WS_SRC/$PROJECT_NAME" ]; then
  git clone -b $BRANCH https://bitbucket.org/ANPL/$PROJECT_NAME.git $WS_SRC/$PROJECT_NAME && TMP=1
	if [ $TMP -eq 1 ]; then
	echo "'${0##*/}' SUCCEED"
else
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 	echo "'${0##*/}' FAILED"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exit
fi 
fi


echo "source $WS_PATH/devel/setup.bash" >> ~/.bashrc
source $WS_PATH/devel/setup.bash
