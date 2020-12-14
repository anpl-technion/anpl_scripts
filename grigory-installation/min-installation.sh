#!/bin/bash

UBUNTU_DISTRO=$(cat /etc/os-release | grep -i version_id | cut -d'"' -f2)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
VISION=false
CUSTOM_CORE=false

case $UBUNTU_DISTRO in
	16.04) ;;
	18.04) ;;
	*) 	read -p $'Installation script currently only available on Ubuntu 16.04 and Ubuntu 16.04. Installation cancelled.'
		exit;;
esac

########### "source ~/.bashrc" command from non-interactive shell ###########
source_bashrc(){
	cp ~/.bashrc ~/.bashrc_copy
	sudo tail -n +10 ~/.bashrc_copy | tee ~/.bashrc | sleep 1 #remove check for interactiveness
	source ~/.bashrc
	mv ~/.bashrc_copy ~/.bashrc
}


########### Installation routines ###########
anpl_mrbsp_gtsam4(){
	# carkin belief:
	bash install-libspdlog.sh --apt=false  & wait $! #(apt=false, from git) - mrbsp_utils wanted it
	bash install-octomap.sh & wait $!	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it 
	bash install-libccd.sh --apt=false  & wait $! #(AG need it - apt=false)
	bash install-libfcl.sh --apt=true & wait $! #(AG need it - apt=true)
	bash install-ompl.sh --apt=false & wait $! #(AG need it, apt=false)

	bash install-diverse-short-path.sh & wait $!	#(AG need it)
	bash install-csm.sh --apt=false & wait $!	#(git=true)

	bash install-find-cmakes.sh & wait $!

	bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)

	sudo apt-get install xterm  -y
	sudo apt-get install graphviz-dev -y
}

#=============================
#	new_inf GTSAM3 LiDAR
#=============================
anpl_mrbsp_master(){
	# catkin belief:
	bash install-libspdlog.sh --apt=false & wait $! #(apt=false, from git) - mrbsp_utils wanted it
	bash install-octomap.sh   & wait $!	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it [sudo update and upgrade]
	bash install-libccd.sh --apt=true & wait $!	#(AG need it - apt=true)
	bash install-libfcl.sh --apt=true & wait $!	#(AG need it - apt=true)
	bash install-ompl.sh --apt=false & wait $!  	#(AG need it, apt=false)

	bash install-diverse-short-path.sh & wait $!  	#(AG need it)
	bash install-csm.sh & wait $! 					#(git=true)

	bash install-find-cmakes.sh & wait $!

	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!

	sudo apt-get install xterm  -y
	sudo apt-get install graphviz-dev -y
}

#=============================
#	old_inf LiDAR
#=============================
mrbsp_ros_t-bsp-julia(){
	# catkin belief:
	bash install-libspdlog.sh --apt=true & wait $! #(apt=true, from git) - mrbsp_utils wanted it
	bash install-octomap.sh & wait $!	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it [sudo update and upgrade]
	bash install-libccd.sh --apt=true & wait $!	#(AG need it - apt=true)
	bash install-libfcl.sh --apt=true & wait $!	#(AG need it - apt=true)
	bash install-ompl.sh --apt=false & wait $!  	#(AG need it, apt=false)

	bash install-diverse-short-path.sh & wait $!  	#(AG need it)
	bash install-csm.sh & wait $! 			#(git=true)

	bash install-find-cmakes.sh & wait $!

	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!

	bash install-mavros.sh & wait $! # required by pixhawk_controller

	sudo apt-get install xterm  -y
	sudo apt-get install graphviz-dev -y
}

#=============================
#	old_inf ORB-SLAM
#=============================
mrbsp_ros_or-vi_project(){
	# TODO: test
	bash install-libspdlog.sh --apt=true & wait $! #(apt=true, from git) - mrbsp_utils wanted it
	bash install-octomap.sh & wait $!	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it [su
	bash install-libccd.sh --apt=true  & wait $!	#(AG need it - apt=true)
	bash install-libfcl.sh --apt=true & wait $!	#(AG need it - apt=true)
	bash install-ompl.sh --apt=false & wait $!  	#(AG need it, apt=false)

	bash install-diverse-short-path.sh & wait $!  	#(AG need it)
	bash install-csm.sh & wait $! 			#(git=true)

	bash install-find-cmakes.sh & wait $!

	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!

	bash install-mavros.sh & wait $! # required by pixhawk_controller

	sudo apt-get install xterm  -y
	sudo apt-get install graphviz-dev -y
}


######################## Script starts here ########################

case $UBUNTU_DISTRO in
	16.04) ;;
	18.04) ;;
	*) 	read -p $'Installation script currently only available on Ubuntu 16.04 and Ubuntu 16.04. Installation cancelled.'
		exit;;
esac
############################ Inputs read ############################
echo -e "\033[0;36mWelcome to ANPL's Multi-Robot Belief Space Planner open source project installator!"
echo -e "Before installation please check if you have account @BitBucket and have full access to ANPL repository. If you don't please contact Vadim to get an access.\033[0m"
while true; do
    read -p "Do you wish to continue?[Y/n]" yn
    case $yn in
        [Yy] ) break;;
        [Nn] ) exit;;
        * ) echo "Please answer 'y' or 'n'";;
    esac
done

echo -e $'\033[0;42m Choosing Infrastructure \033[0m'
while true; do
	read -p $'Choose which infrastructure you want: \n\t1. anpl_mrbsp[NEW]\n\t2. mrbsp_ros[OLD]\n: ' NUM
	case $NUM in
		[1] ) PROJECT_NAME=anpl_mrbsp
			echo -e "\033[0;42m Choosing Branch \033[0m"
			while true; do
				read -p $'Choose which branch you want: \n\t1. master[Lidar-gtsam3]\n\t2. gtsam4[Lidar-gtsam4]\n: ' NUM
				case $NUM in
					[1] ) BRANCH=master
						GTSAM_VER=3;;
					[2] ) BRANCH=gtsam4
						GTSAM_VER=4;;
				esac
				case $NUM in
					[12] ) break;;
					* ) echo -e "\033[0;41m Please choose correct option.\033[0m";;
				esac
			done
			break
			;;
		[2] ) PROJECT_NAME=mrbsp_ros
			echo -e "\033[0;42m Choosing Branch \033[0m"
			while true; do
				read -p $'Choose which branch you want: \n\t1. t-bsp-julia[Lidar]\n\t2. or-vi_project[VISION] \n: ' NUM
				GTSAM_VER=3
				case $NUM in
					[1] ) BRANCH=t-bsp-julia;;
					[2] ) BRANCH=or-vi_project
						VISION=true;;
				esac
				case $NUM in
					[12] ) break;;
					* ) echo -e "\033[0;41m Please choose correct option.\033[0m";;
				esac
			done
			break
			;;
		*) echo -e "\033[0;41m Please choose correct option.\033[0m"
			;;
	esac
done

case $GTSAM_VER in
	[3] ) PLANAR_BRANCH=master;;
	[4] ) PLANAR_BRANCH=gtsam4;;
esac

if [ $GTSAM_VER == 3 -a $UBUNTU_DISTRO == 18.04 ]; then
	echo "Sorry, the configuration you choosed is not currently supported. GTSAM-3.2.1 cannot be install on Ubuntu 18.04 due to Boost version conflict. "
	exit
fi

echo -e $'\033[0;42m Choosing installation option \033[0m'
while true; do
	read -p $'What robots you going to use: \n\t1. Pioneer \n\t2. Quad \n\t3. Pioneer and Quad \n\t4. Simulator only\n: ' NUM
	case $NUM in
		[1] ) ROBOTS=pioneer;;
		[2] ) ROBOTS=quad;;
		[3] ) ROBOTS=pioneer+quad;;
		[4] ) ROBOTS=simulator;;
	esac
	case $NUM in
		[123] )
			while true; do
				read -p $'Do you wish to install simulator and models? [Y/n]\n: ' yn
				case $yn in
					[Yy] ) ROBOTS=$ROBOTS+simulator
							break;;
					[Nn] ) break;;
					* ) echo "Please answer 'y' or 'n'";;
				esac
				done
			break;;
		[4] ) break;;
		* ) echo -e "\033[0;41m Please choose correct option.\033[0m";;
	esac
done
while true; do
	read -p $'Which sensors you going to use: \n\t1. LiDAR [installed with ROS] \n\t2. ZED Camera \n\t3. Both LiDAR and ZED \n: ' NUM
	case $NUM in
		[1] ) SENSORS=lidar;;
		[2] ) SENSORS=zed;;
		[3] ) SENSORS=lidar+zed;;
	esac
	case $NUM in
		[123] ) break;;
		* ) echo -e "\033[0;41m Please choose correct option.\033[0m";;
	esac
done
while true; do
	if [[ $ROBOTS =~ "simulator" ]]; then
		ROS_OPTION=desktop-full
		break
	fi
	read -p $'Which sensors you going to use: \n\t1. Desktop-Full(Recommended) : ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators \n\t2. Desktop: ROS, rqt, rviz, and robot-generic libraries\n: ' NUM
	case $NUM in
		[1] ) ROS_OPTION=desktop-full;;
		[2] ) ROS_OPTION=desktop;;
	esac
	case $NUM in
		[12] ) break;;
		* ) echo -e "\033[0;41m Please choose correct option.\033[0m";;
	esac
done

################### Setups and General Installations ####################
bash show-git-branch.sh
git config --global credential.helper 'cache --timeout 3600'

echo "export PATH=$PATH:$SCRIPT_DIR" >> ~/.bashrc
#echo "export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/arm-linux-gnueabihf/pkgconfig" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/ANPLprefix/lib" >> ~/.bashrc

# Essential prefix folder; used for from-source dependencies
sudo mkdir /usr/ANPLprefix/
cd $SCRIPT_DIR/src/

case $UBUNTU_DISTRO in
	16.04) bash install-ros-kinetic.sh $ROS_OPTION;;
	18.04) bash install-ros-melodic.sh $ROS_OPTION;;
	*) read -p $'Installation script currently only available on Ubuntu 16.04 and Ubuntu 18.04. Installation cancelled.'
		exit;;
esac
source_bashrc
bash install-ros-packages.sh
bash install-mrbsp-infrastructure.sh --infrastructure=$PROJECT_NAME --branch=$BRANCH
source_bashrc
bash install-gtsam${GTSAM_VER}.sh & wait $!

#################### Robot nodes ####################
if [[ $ROBOTS =~ "pioneer" ]]; then
	bash install-pioneer-nodes.sh
	# rosaria fix: run twice, dk why
	bash install-rosaria.sh
fi
if [[ $ROBOTS =~ "quad" ]]; then
	bash install-mavros.sh
fi
if [[ $ROBOTS =~ "simulator" ]]; then
	bash install-simulator-nodes.sh
fi

#################### Sensors nodes ####################
if [[ $SENSORS =~ "lidar" ]]; then
	if uname -r | grep -q tegra; then
		echo $'Please follow this guide to connect LiDAR on JETSON: \n https://docs.google.com/document/d/1Ld4tVww0eDBu5-UsM51ayD490puqnh13nm5DjGhK7js/edit'
		read -p "Press ENTR when you done..."
	fi
fi
if [[ $SENSORS =~ "zed" ]]; then
	echo "Please install CUDA manually before continue. Install CUDA 9.2 on PC and 9.0 on Jetson."
	echo "Ask your Lab Engineer if version of cuda changed."
	read -p "Press ENTR when you done..." 
	if uname -r | grep -q tegra; then
		echo $'Please install ZED-SDK 2.x.x manually: https://www.stereolabs.com/docs/installation/jetson/'
		read -p "Press ENTR when you done..."
	else
		bash install-zed-sdk.sh & wait $!
	fi
fi

########### Call for appropriate installation routine ###########
###### The routine could be consired as core installation #######
case $CUSTOM_CORE; in
	true)
		# Put your custom core installation here
		;;
	*)
		"$PROJECT_NAME"_"$BRANCH"
		;;
esac

if [ $VISION ]; then
	bash install-vlfeat.sh & wait $!
	#bash install-libpcl-1.8.sh & wait $!
	#bash install-cuda9.2.sh & wait $!
	#bash install-zed-sdk.sh & wait $!
	bash install-orbslam2.sh & wait $!
	#bash install-viso2.sh & wait $!

fi

########### Gazebo's 'Error in REST request' fix ###########
if [ -f "~/.ignition/fuel/config.yaml" ]; then 
	sed -i "s+https://api.ignitionfuel.org+https://api.ignitionrobotics.org+g" ~/.ignition/fuel/config.yaml
fi

########### Build ###########
# mapper compilation requiers about 5G RAM on each core
# so we create additional swap space on disk.
while true; do
	read -p $'We are about to build the infrastructure. Do you want to add swap space to your device? [Y/n]\n: ' yn
	case $yn in
		[Yy] )
			SWAP=true
			while true; do
				read -p $'Type how many Gb you want to allocate? Be sure you have enough space on your hard drive.\n: ' SWAP_SIZE
				if [[ -n ${SWAP_SIZE//[0-9]/} ]]; then
					echo 'Please choose correct option.'
				elif [ $SWAP_SIZE -lt 0 ]; then
					echo 'Please choose correct option.'
				else
					break
				fi
			done
			break
			;;
        [Nn] ) break;;
        * ) echo "Please answer 'y' or 'n'";;
    esac
done

if [ $SWAP ]; then
	sudo fallocate -l ${SWAP_SIZE}G /tmpswapfile
	sudo chmod 600 /tmpswapfile
	sudo mkswap /tmpswapfile
	sudo swapon /tmpswapfile
fi
# build
cd ~/ANPL/infrastructure/mrbsp_ws
catkin build -j3

# and remove swap space
if [ $SWAP ]; then
	sudo swapoff -v /tmpswapfile
	sudo rm /tmpswapfile
fi

echo -e "\033[0;36m ++++  End of installation ++++    \033[0m"

