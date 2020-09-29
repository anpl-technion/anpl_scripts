#!/bin/bash

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

	while true; do
		echo "Please specify if you want to use a default version of OMPL. This option is recommended if you are NOT planning to work with custom version of OMPL. Otherwise, OMPL library version 1.4.2 will be installed inside ANPLprefix. If you further want to upgrade the version, please refer to 'install-ompl.sh' script."
		read -p "Do you want to install default version of OMPL?(Recommended) [Y/n]" yn
			case $yn in
			[Yy]* )
				bash install-ompl.sh --apt=true & wait $! #(AG need it, apt=true)
				# 'set-ompl-from-apt.sh' modifies action generator CMake
				bash set-ompl-from-apt.sh & wait $!
				break
			;;
			[Nn]* )
				bash install-ompl.sh --apt=false & wait $! 
				AG_CMAKE_PATH=~/ANPL/infrastructure/mrbsp_ws/src/anpl_mrbsp/action_generator/CMakeLists.txt
				read -p "To make OMPL 1.4.2 accecable to the infrastructure, please go to $AG_CMAKE_PATH right now and read lines 74-80 carefully\n" ENTR
				break
			;;
			* ) echo "Please answer yes or no.";;
	    esac
	done

	bash install-diverse-short-path.sh & wait $!	#(AG need it)
	bash install-csm.sh --apt=false & wait $!	#(git=true)
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)
	bash install-find-cmakes.sh & wait $!

	if [[ "$ROBOTS" =~ "pioneer" ]]; then 
		bash install-rosaria.sh & wait $!
		ROSARIA_CMAKE_PATH=~/ANPL/infrastructure/mrbsp_ws/src/rosaria/CMakeLists.txt
		sed -ie '/^#set(ROS_BUILD_TYPE RelWithDebInfo)/a add_compile_options(-std=c++11)' $ROSARIA_CMAKE_PATH
	fi
	if [[ "$ROBOTS" =~ "quad" ]]; then
		bash install-mavros.sh & wait $!
	fi

	JSON_C_BITS_LINES_TO_BE_COMMENTED=('#ifndef min' \
		'#define min(a,b) ((a) < (b) ? (a) : (b))' \
		'#endif' \
		'#ifndef max' \
		'#define max(a,b) ((a) > (b) ? (a) : (b))')
	JSON_C_BITS_PATH=/usr/ANPLprefix/include/json-c/bits.h
	for line in "${JSON_C_BITS_LINES_TO_BE_COMMENTED[@]}"
	do
		sudo sed -i "s|${line}|//${line}|" $JSON_C_BITS_PATH
	done
	echo "#endif" | sudo tee -a $JSON_C_BITS_PATH

	sudo apt-get install xterm graphiz-dev -y & wait $!
}


anpl_mrbsp_quad-interactive(){
	# carkin belief:
	bash install-libspdlog.sh --apt=false  & wait $! #(apt=false, from git) - mrbsp_utils wanted it
	bash install-octomap.sh & wait $!	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it [sudo update and upgrade]
	bash install-libccd.sh --apt=false  & wait $! #(AG need it - apt=false)
	bash install-libfcl.sh --apt=true & wait $! #(AG need it - apt=true)
	bash install-ompl.sh   --apt=true & wait $! #(AG need it, apt=true)
	bash install-diverse-short-path.sh & wait $!	#(AG need it)
	bash install-csm.sh --apt=false & wait $!	#(git=true)
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)
	#bash install-libpcl-1.8.sh & wait $!
	bash install-find-cmakes.sh & wait $!

	if [[ "$ROBOTS" =~ "quad" ]]; then
		bash install-mavros.sh & wait $!
	fi

	JSON_C_BITS_LINES_TO_BE_COMMENTED=('#ifndef min' \
		'#define min(a,b) ((a) < (b) ? (a) : (b))' \
		'#endif' \
		'#ifndef max' \
		'#define max(a,b) ((a) > (b) ? (a) : (b))')
	JSON_C_BITS_PATH=/usr/ANPLprefix/include/json-c/bits.h
	for line in "${JSON_C_BITS_LINES_TO_BE_COMMENTED[@]}"
	do
		sudo sed -i "s|${line}|//${line}|" $JSON_C_BITS_PATH
	done
	echo "#endif" | sudo tee -a $JSON_C_BITS_PATH

	sudo apt-get install xterm graphiz-dev -y & wait $!

	if ! uname -r | grep -q tegra; then
		bash install-cuda9.2.sh & wait $!
		bash install-zed-sdk.sh & wait $!
	else
		read -p "Please install JetPack and CUDA manually. Use Ariel's manuals on JIRA to find out versions you need.\n"
	fi
}


######################## Script starts here ########################
PLANAR_BRANCH=gtsam4

echo -e "\033[0;36mWelcome to ANPL's Multi-Robot Belief Space Planner open source project installator!"
echo -e "Before installation please check if you have account @BitBucket and have full access to ANPL repository. If you don't please contact Vadim to get an access.\033[0m"
while true; do
    read -p "Do you wish to continue?[Y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e $'\033[0;42m Choosing Infrastructure \033[0m'
read -p $'Choose which infrastructure you want: \n\t1. (anpl_mrbsp[NEW]): \n' NUM
echo
case $NUM in
	[1]* ) PROJECT_NAME=anpl_mrbsp
		echo -e "\033[0;42m Choosing Branch \033[0m"
		read -p $'Choose which branch you want: \n\t1. gtsam4[Lidar-gtsam4] \n\t2. quad-interactive \n' NUM
		echo
		case $NUM in
			[1]* ) BRANCH=gtsam4;;
			[2]* ) BRANCH=quad-interactive;;
       		* ) echo "Please choose correct option. Rerun minimal-inst.sh"
				exit ;;
		esac;;
	* ) echo "Please choose correct option. Rerun minimal-inst.sh"
		exit ;;
esac

echo -e $'\033[0;42m Choosing installation option \033[0m'
read -p $'What robots you going to use: \n\t1. Pioneer \n\t2. Quad \n\t3. Pioneer and Quad\n' NUM
case $NUM in 
	[1]* ) ROBOTS=pioneer;;
	[2]* ) ROBOTS=quad;;
	[3]* ) ROBOTS=pioneer+quad;;
	* ) echo "Please choose correct option. Rerun minimal-inst.sh"
	exit ;;
esac

bash show-git-branch.sh
git config --global credential.helper 'cache --timeout 3600'

cd src/
echo "export PATH=$PATH:$(pwd)" >> ~/.bashrc

bash install-ros-melodic.sh & wait $!
source_bashrc
bash install-gtsam4.sh & wait $!
bash install-ros-packages.sh & wait $!
bash setup-anpl-mrbsp.sh --infrastructure=$PROJECT_NAME --branch=$BRANCH & wait $!
source_bashrc

########### Call for appropriate installation routine ###########
"$PROJECT_NAME"_"$BRANCH"

########### Gazebo's 'Error in REST request' fix ###########
if [ -f "~/.ignition/fuel/config.yaml" ]; then 
	sed -i "s+https://api.ignitionfuel.org+https://api.ignitionrobotics.org+g" ~/.ignition/fuel/config.yaml
fi

# mapper compilation requiers about 5G RAM on each core
# so we create additional swap space on disk.
sudo fallocate -l 8G /tmpswapfile
sudo chmod 600 /tmpswapfile
sudo mkswap /tmpswapfile
sudo swapon /tmpswapfile
# build
catkin build -j3
# and remove swap space
sudo swapoff -v /tmpswapfile
sudo rm /tmpswapfile

echo -e "\033[0;36m ++++  End of installation ++++    \033[0m"

