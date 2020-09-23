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
				AG_CMAKE_LINES=('list(APPEND CMAKE_MODULE_PATH ${ANPL_PREFIX}/share/cmake)' \
						'set(OMPL_PREFIX ${ANPL_PREFIX})')
				AG_CMAKE_PATH=~/ANPL/infrastructure/mrbsp_ws/src/anpl_mrbsp/action_generator/CMakeLists.txt
				for line in "${AG_CMAKE_LINES[@]}"; do
					# comment lines in ag CMake 
					sed -i "s|${line}|#${line}|" $AG_CMAKE_PATH
				done
				break
			;;
			[Nn]* )
				bash install-ompl.sh --apt=false & wait $! 
				read -p "To make OMPL 1.4.2 accecable to the infrastructure, please go to $AG_CMAKE_PATH right now and read lines 74-80 carefully" ENTR
				break
			;;
			* ) echo "Please answer yes or no.";;
	    esac
	done

	bash install-diverse-short-path.sh & wait $!	#(AG need it)
	bash install-csm.sh --apt=false & wait $!	#(git=true)

	bash install-rosaria.sh & wait $!
	ROSARIA_CMAKE_PATH=~/ANPL/infrastructure/mrbsp_ws/src/rosaria/CMakeLists.txt
	sed -ie '/^#set(ROS_BUILD_TYPE RelWithDebInfo)/a add_compile_options(-std=c++11)' $ROSARIA_CMAKE_PATH

	bash install-find-cmakes.sh & wait $!

	JSON_C_BITS_LINES_TO_BE_COMMENTED=('#ifndef min' \
		'#define min(a,b) ((a) < (b) ? (a) : (b))' \
		'#endif' \
		'#ifndef max' \
		'#define max(a,b) ((a) > (b) ? (a) : (b))'\
		)
	JSON_C_BITS_PATH=/usr/ANPLprefix/include/json-c/bits.h
	for line in "${JSON_C_BITS_LINES_TO_BE_COMMENTED[@]}"
	do
		sudo sed -i "s|${line}|//${line}|" $JSON_C_BITS_PATH
	done
	echo "#endif" | sudo tee -a $JSON_C_BITS_PATH

	bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)
	sudo cp -r cmake /usr/ANPLprefix/share/

	sudo apt-get install xterm graphiz-dev -y & wait $!
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
		echo -e $"\033[0;42m Choosing Branch \033[0m"
		read -p $'Choose which branch you want: \n\t1. gtsam4[Lidar-gtsam4] \n' NUM
		echo
		case $NUM in
			[1]* ) BRANCH=gtsam4;;
       		* ) echo "Please choose correct option. Rerun minimal-inst.sh"
				exit ;;
		esac;;
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

