#!/bin/bash

UBUNTU_DISTRO=$(cat /etc/os-release | grep -i version_id | cut -d'"' -f2)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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

echo -e $'\033[0;42m Choosing Infrastructure \033[0m'
while true; do
	read -p $'Choose which infrastructure you want: \n\t1. anpl_mrbsp[NEW]\n\t2. mrbsp_ros[OLD]\nChoose an option: ' NUM
	case $NUM in
		[1] ) PROJECT_NAME=anpl_mrbsp
			echo -e "\033[0;42m Choosing Branch \033[0m"
			while true; do
				read -p $'Choose which branch you want: \n\t1. master[Lidar-gtsam3]\n\t2. gtsam4[Lidar-gtsam4]\nChoose an option: ' NUM
				case $NUM in
					[1] ) BRANCH=master;;
					[2] ) BRANCH=gtsam4;;
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
				read -p $'Choose which branch you want: \n\t1. t-bsp-julia[Lidar]\n\t2. or-vi_project[VISION] \nChoose an option: ' NUM
				GTSAM_VER=3
				case $NUM in
					[1] ) BRANCH=t-bsp-julia;;
					[2] ) BRANCH=or-vi_project;;
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

################### End of read inputs ###################
bash show-git-branch.sh

# ros 
case $UBUNTU_DISTRO in
	16.04) echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc;;
	18.04) echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc;;
	*) read -p $'Installation script currently only available on Ubuntu 16.04 and Ubuntu 18.04. Installation cancelled.'
		exit;;
esac
# from-source libs
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/ANPLprefix/lib" >>~/.bashrc
# cuda
echo "export PATH=\$PATH:/usr/local/cuda/bin/" >>~/.bashrc
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >>~/.bashrc

source_bashrc

cd $SCRIPT_DIR/src/
bash install-mrbsp-infrastructure.sh --infrastructure=$PROJECT_NAME --branch=$BRANCH

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
	if [ ! -d "/usr/local/cuda" ]; then
		echo "Please install CUDA manually before continue. Install CUDA 9.2 on PC and 9.0 on Jetson."
		echo "Ask your Lab Engineer if version of cuda changed."
		read -p "Press ENTR when you done..." 
	fi
	if [ ! -d "/usr/local/zed" ]; then
		if uname -r | grep -q tegra; then
			echo $'Please install ZED-SDK 2.x.x manually: https://www.stereolabs.com/docs/installation/jetson/'
			read -p "Press ENTR when you done..."
		else
			bash install-zed-sdk.sh & wait $!
		fi
	fi
fi

#################### Build ####################
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

echo -e "\033[0;36m ++++  End of installation ++++    \033[0m"