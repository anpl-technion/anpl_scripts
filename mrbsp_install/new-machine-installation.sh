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

################ multi choose read interface ################
read_menu() {
    options=("$@")
    echo "Avaliable options:"
    for i in ${!options[@]}; do
        echo -e "${choices[i]:-}\t " $((i+1))"." "${options[i]}"
    done
}
multi_option_read() {
    options=("$@")
    choices=()
    echo "Check options (space separated; double check to uncheck; ENTER when done):"
    prompt="Choose an options: "
    while read_menu ${options[@]} && read -rp "$prompt" nums && [[ "$nums" ]]; do
        while read num; do
            [[ "$num" != *[![:digit:]]* ]] &&
				(( num > 0 && num <= ${#options[@]} )) ||
				{ echo "Invalid option: $num"; continue; }
            ((num--));
            [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
        done < <(echo $nums |sed "s/ /\n/g")
    done
    MULTI_ROBOT_READ_OUTPUT=$(
        for i in ${!options[@]}; do
            [[ "${choices[i]}" ]] && { echo -n "${options[i],,}+" ;}
        done
    )
    [ ! -z "$MULTI_ROBOT_READ_OUTPUT" ] &&
		{ MULTI_ROBOT_READ_OUTPUT=${MULTI_ROBOT_READ_OUTPUT::-1} ;}
    declare -a MULTI_ROBOT_READ_OUTPUT
}

#=============================
#	ANPL_MRBSP core routine
#=============================
anpl_mrbsp_core(){
	# mrbsp_utils node
	bash install-libspdlog.sh --apt=false & wait $!
	bash install-octomap.sh & wait $!

	# Acrion Generator node & many others
	bash install-libccd.sh --apt=false  & wait $!
	bash install-libfcl.sh --apt=true & wait $!
	bash install-ompl.sh --apt=false & wait $!
	bash install-diverse-short-path.sh & wait $!
	# Data Association node
	bash install-csm.sh --apt=false & wait $!

	bash install-find-cmakes.sh & wait $!
	# Belief node
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)

	# Planner node
	sudo apt-get install xterm  -y
	sudo apt-get install graphviz-dev -y
}

#=============================
#	MRBSP_ROS core routine 
#=============================
mrbsp_ros_core(){
	# mrbsp_utils node
	bash install-libspdlog.sh --apt=true & wait $!
	bash install-octomap.sh & wait $!
	
	# Acrion Generator node & many others
	bash install-libccd.sh --apt=true & wait $!
	bash install-libfcl.sh --apt=true & wait $!
	bash install-ompl.sh --apt=false & wait $!
	bash install-diverse-short-path.sh & wait $!
	
	# Data Association node
	bash install-csm.sh & wait $!

	bash install-find-cmakes.sh & wait $!
	# Belief node
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!

	# Pixhawk Controller node
	bash install-mavros.sh & wait $!

	# Planner node
	sudo apt-get install xterm  -y
	sudo apt-get install graphviz-dev -y
}

#=============================
#	MRBSP_ROS universal core routine
#=============================
# 	Universal = (almost) evertything from-source
universal_core(){
	# mrbsp_utils node
	bash install-libspdlog.sh --apt=true & wait $!
	bash install-octomap.sh & wait $!
	
	# Acrion Generator node & many others
	bash install-libccd.sh --apt=false & wait $!
	bash install-libfcl.sh --apt=false & wait $!
	bash install-ompl.sh --apt=false & wait $!
	bash install-diverse-short-path.sh & wait $!

	# Data Association node
	bash install-csm.sh & wait $!

	bash install-find-cmakes.sh & wait $!
	# Belief node
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!

	# Pixhawk Controller node
	bash install-mavros.sh & wait $! 

	# Planner node
	sudo apt-get install xterm  -y
	sudo apt-get install graphviz-dev -y
}


######################## Script starts here ########################

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

PROJECT_NAME=anpl_mrbsp
			echo -e "\033[0;42m Choosing Branch \033[0m"
			while true; do
				read -p $'Choose which branch you want: \n\t1. master[Lidar-gtsam3]\n\t2. gtsam4[Lidar-gtsam4]\nChoose an option: ' NUM
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
	echo 'What robots are you going to use?'
	ROBOT_OPTIONS=( Pioneer Quad Simulator )
	multi_option_read "${ROBOT_OPTIONS[@]}"
	ROBOTS=${MULTI_ROBOT_READ_OUTPUT}

	case $ROBOTS in
		'') echo -e "\033[0;41m Please choose at least one option.\033[0m";;
		*) break;;
	esac
done
while true; do
	echo 'What sensors are you going to use?'
	SENSOR_OPTIONS=( LiDAR ZED )
	multi_option_read "${SENSOR_OPTIONS[@]}"
	SENSORS=${MULTI_ROBOT_READ_OUTPUT}

	case $SENSORS in
		'') echo -e "\033[0;41m Please choose at least one option.\033[0m";;
		*) break;;
	esac
done
while true; do
	if [[ $ROBOTS =~ "simulator" ]]; then
		ROS_OPTION=desktop-full
		break
	fi
	read -p $'Which sensors you going to use: \n\t1. Desktop-Full(Recommended) : ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators \n\t2. Desktop: ROS, rqt, rviz, and robot-generic libraries\nChoose an option: ' NUM
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
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ANPL_PREFIX/lib" >> ~/.bashrc

# Essential prefix folder; used for from-source dependencies

sudo mkdir $ANPL_PREFIX
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
		echo $'Please follow this guide to connect LiDAR on JETSON: \nhttps://docs.google.com/document/d/1Ld4tVww0eDBu5-UsM51ayD490puqnh13nm5DjGhK7js/edit'
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
case $CUSTOM_CORE in
	true)
		# Put your custom core installation here:
		# universal_core
		;;
	*)
		"$PROJECT_NAME"_core
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
					echo 'Please enter integer value.'
				elif [ $SWAP_SIZE -lt 0 ]; then
					echo 'Please provide positive integer.'
				else
					break
				fi
			done
			break
			;;
        [Nn] ) 
			SWAP=false
			break
			;;
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

echo "export EDITOR='gedit' #ROS text editor" >> ~/.bashrc
source ~/.bashrc

echo -e "\033[0;36m ++++  End of installation ++++    \033[0m"

