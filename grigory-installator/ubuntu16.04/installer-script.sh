#!/bin/bash

source_bashrc(){
	cp ~/.bashrc ~/.bashrc_copy
	sudo tail -n +10 ~/.bashrc_copy | tee ~/.bashrc | sleep 1 #remove check for interactiveness
	source ~/.bashrc
	mv ~/.bashrc_copy ~/.bashrc
}

#=============================
#	new_inf LiDAR
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
	mrbsp_ros_t-bsp-julia & wait $!
	#install-vlfeat.sh
	#install-libpcl-1.8.sh
	#install-cuda9.2.sh
	#install-orbslam2.sh
	#install-zed-sdk.sh
}


#==================================
#	Script starts here
echo -e "\033[0;36mWelcome to ANPL's Multi-Robot Belief Space Planner open source installator!"
echo -e "Before installation please check if you have account @BitBucket and have full access to ANPL repository. If you don't please contact Vadim to get an access.\033[0m"
while true; do
    read -p "Do you wish to continue?[Y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo -e "\033[0;42m Choosing Infrastructure \033[0m"
read -p "Choose which infrastructure you want:
	1 - (anpl_mrbsp[NEW])
	2 - (mrbsp_ros[OLD]):    " NUM
echo
case $NUM in
	[1]* ) PROJECT_NAME=anpl_mrbsp
		echo -e "\033[0;42m Choosing Branch \033[0m"
		read -p "Choose which branch you want:
		1 - (master[Lidar-gtsam3])" NUM
		echo
		case $NUM in
		[1]* ) BRANCH=master;;
		* ) echo "Please choose correct option. Rerun minimal-inst.sh"
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
		* ) echo "Please answer 1 or 2. Rerun '${0##*/}'"
			exit ;;
		esac;;
        * ) echo "Please answer 1 or 2. Rerun '${0##*/}'"
	exit ;;
esac

PLANAR_BRANCH=master
bash show-git-branch.sh
cd src/
echo "export PATH=$PATH:$(pwd)" >> ~/.bashrc


bash install-ros-kinetic.sh
source_bashrc
bash install-gtsam.sh
bash install-ros-packages.sh 
bash setup-anpl-mrbsp.sh --infrastructure=$PROJECT_NAME --branch=$BRANCH & wait $!

source_bashrc
# Redirecting stderr to log file
"$PROJECT_NAME"_"$BRANCH" 2> ../log.err
echo -e "\033[0;36m ++++  End of installation ++++    \033[0m";
cd ~/ANPL/infrastructure/mrbsp_ws & catkin build
