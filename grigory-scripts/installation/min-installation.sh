#!/bin/bash

########### "source ~/.bashrc" command from non-interactive shell ###########
source_bashrc(){
	cp ~/.bashrc ~/.bashrc_copy
	sudo tail -n +10 ~/.bashrc_copy | tee ~/.bashrc | sleep 1 #remove check for interactiveness
	source ~/.bashrc
	mv ~/.bashrc_copy ~/.bashrc
}
json_bits(){
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

	json_bits
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)
	bash install-find-cmakes.sh & wait $!

	bash install-rosaria.sh & wait $!
	ROSARIA_CMAKE_PATH=~/ANPL/infrastructure/mrbsp_ws/src/rosaria/CMakeLists.txt
	sed -ie '/^#set(ROS_BUILD_TYPE RelWithDebInfo)/a add_compile_options(-std=c++11)' $ROSARIA_CMAKE_PATH

	sudo apt-get install xterm  -y
	# Ubuntu 16 only
	sudo apt-get install graphviz-dev -y
}


anpl_mrbsp_quad-interactive(){
	# carkin belief:
	bash install-libspdlog.sh --apt=false  & wait $! #(apt=false, from git) - mrbsp_utils wanted it
	bash install-octomap.sh & wait $!	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it [sudo update and upgrade]
	bash install-libccd.sh --apt=false  & wait $! #(AG need it - apt=false)
	bash install-libfcl.sh --apt=true & wait $! #(AG need it - apt=true)
	bash install-ompl.sh   --apt=false & wait $! #(AG need it, apt=false)

	bash install-diverse-short-path.sh & wait $!	#(AG need it)
	bash install-csm.sh --apt=false & wait $!	#(git=true)

	json_bits	
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)
	#bash install-libpcl-1.8.sh & wait $!
	bash install-find-cmakes.sh & wait $!

	sudo apt-get install xterm graphiz-dev -y & wait $!

	if ! uname -r | grep -q tegra; then
		bash install-cuda9.2.sh & wait $!
		bash install-zed-sdk.sh & wait $!
	else
		read -p "Please install JetPack and CUDA manually. Use Ariel's manuals on JIRA to find out versions you need.\n"
	fi
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

	bash install-rosaria.sh & wait $!
	bash install-find-cmakes.sh & wait $!
	
	json_bits
	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!
	sudo apt-get install xterm graphviz-dev -y
	sudo cp -r cmake /usr/ANPLprefix/share/

	cd ~/ANPL/infrastructure/mrbsp_ws/src/rosaria 
	sed -ie '/^#set(ROS_BUILD_TYPE RelWithDebInfo)/a add_compile_options(-std=c++11)' CMakeLists.txt
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

	bash install-rosaria.sh & wait $!
	bash install-mavros.sh & wait $!

	json_bits
	bash install-rotors-simulation.sh & wait $!
	bash install-find-cmakes.sh & wait $!

	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!
	sudo apt-get install xterm graphviz-dev -y
	sudo cp -r cmake /usr/ANPLprefix/share/
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

	bash install-rosaria.sh & wait $!
	bash install-mavros.sh & wait $!

	json_bits
	bash install-rotors-simulation.sh & wait $!
	bash install-find-cmakes.sh & wait $!

	bash install-planar-icp.sh --branch=$PLANAR_BRANCH & wait $!
	sudo apt-get install xterm graphviz-dev -y
	sudo cp -r cmake /usr/ANPLprefix/share/

	bash install-vlfeat.sh & wait $!
	bash install-libpcl-1.8.sh & wait $!
	bash install-cuda9.2.sh & wait $!
	bash install-orbslam2.sh & wait $!
	bash install-zed-sdk.sh & wait $!
	bash install-viso2.sh & wait $!
}


######################## Script starts here ########################
UBUNTU_DISTRO=$(cat /etc/os-release | grep -i version_id | cut -d'"' -f2)

case $UBUNTU_DISTRO in
	16.04) ;;
	18.04) ;;
	*) 	read -p $'Installation script currently only available on Ubuntu 16.04 and Ubuntu 16.04. Installation cancelled.'
		exit;;
esac

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
read -p $'Choose which infrastructure you want: \n\t1. anpl_mrbsp[NEW]\n\t2. mrbsp_ros[OLD]\n: ' NUM
echo
case $NUM in
	[1]* ) PROJECT_NAME=anpl_mrbsp
		echo -e "\033[0;42m Choosing Branch \033[0m"
		read -p $'Choose which branch you want: \n\t1. master[Lidar-gtsam3]\n\t2. gtsam4[Lidar-gtsam4] \n\t3. quad-interactive[Lidar] \n: ' NUM
		echo 
		case $NUM in
			[1]* ) BRANCH=master
				GTSAM_VER=3;;
			[2]* ) BRANCH=gtsam4
				GTSAM_VER=4;;
			[3]* ) BRANCH=quad-interactive
				GTSAM_VER=4;;
       		* ) echo "Please choose correct option. Rerun '${0##*/}"
				exit ;;
		esac;;
	[2]* ) PROJECT_NAME=mrbsp_ros
		echo -e "\033[0;42m Choosing Branch \033[0m"
		read -p $'Choose which branch you want: \n\t1. t-bsp-julia[Lidar]\n\t2. or-vi_project[VISION] \n: ' NUM
		echo
		GTSAM_VER=3		
		case $NUM in
			[1]* ) BRANCH=t-bsp-julia;;
			[2]* ) BRANCH=or-vi_project;;
			* ) echo "Please answer 1 or 2. Rerun '${0##*/}'"
				exit ;;
		esac;;
	* ) echo "Please choose correct option. Rerun '${0##*/}'"
		exit ;;
esac

case $GTSAM_VER in
	[3] ) PLANAR_BRANCH=master;;
	[4] ) PLANAR_BRANCH=gtsam4;;
esac

bash show-git-branch.sh
git config --global credential.helper 'cache --timeout 3600'

echo "export PATH=$PATH:$(pwd)" >> ~/.bashrc
echo "export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/arm-linux-gnueabihf/pkgconfig" >> ~/.bashrc

# Essential prefix folder; used for from-source dependencies
sudo mkdir /usr/ANPLprefix/

cd src/
bash install-gtsam${GTSAM_VER}.sh & wait $!
case $UBUNTU_DISTRO in
	16.04) bash install-ros-kinetic.sh;;
	18.04) bash install-ros-melodic.sh;;
	*) read -p $'Installation script currently only available on Ubuntu 16.04 and Ubuntu 16.04. Installation cancelled.'
		exit;;
esac
source_bashrc
bash install-ros-packages.sh & wait $!
bash setup-anpl-mrbsp.sh --infrastructure=$PROJECT_NAME --branch=$BRANCH & wait $!
source_bashrc

########### Call for appropriate installation routine ###########
"$PROJECT_NAME"_"$BRANCH"

########### Gazebo's 'Error in REST request' fix ###########
if [ -f "~/.ignition/fuel/config.yaml" ]; then 
	sed -i "s+https://api.ignitionfuel.org+https://api.ignitionrobotics.org+g" ~/.ignition/fuel/config.yaml
fi

########### Build ###########
# mapper compilation requiers about 5G RAM on each core
# so we create additional swap space on disk.
sudo fallocate -l 8G /tmpswapfile
sudo chmod 600 /tmpswapfile
sudo mkswap /tmpswapfile
sudo swapon /tmpswapfile
# build
cd ~/ANPL/infrastructure/mrbsp_ws
catkin build -j3
# and remove swap space
sudo swapoff -v /tmpswapfile
sudo rm /tmpswapfile

echo -e "\033[0;36m ++++  End of installation ++++    \033[0m"

