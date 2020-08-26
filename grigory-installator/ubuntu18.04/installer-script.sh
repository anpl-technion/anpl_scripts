#!/bin/bash
source_bashrc(){
	cp ~/.bashrc ~/.bashrc_copy
	sudo tail -n +10 ~/.bashrc_copy | tee ~/.bashrc | sleep 1 #remove check for interactiveness
	source ~/.bashrc
	mv ~/.bashrc_copy ~/.bashrc
}

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

PATH=$PATH:$(pwd)/src

echo -e $'\033[0;42m Choosing Infrastructure \033[0m'
read -p $'Choose which infrastructure you want: \n\t1. (anpl_mrbsp[NEW]): \n' NUM
echo
case $NUM in
	[1]* ) PROJECT_NAME=anpl_mrbsp
		echo -e "\033[0;42m Choosing Branch \033[0m"
		read -p $'Choose which branch you want: \n\t1. (gtsam4[Lidar-gtsam4]): \n' NUM
		echo
		case $NUM in
			[1]* ) BRANCH=gtsam4;;
       			* ) echo "Please choose correct option. Rerun minimal-inst.sh"
			exit ;;
		esac;;
        * ) echo "Please choose correct option. Rerun minimal-inst.sh"
	exit ;;
esac

PLANAR_BRANCH=gtsam4
bash show-git-branch.sh
cd src/
echo "export PATH=$PATH:$(pwd)" >> ~/.bashrc
git config --global credential.helper 'cache --timeout 3600'

bash install-ros-melodic.sh & wait $!
source_bashrc
bash install-gtsam4.sh & wait $!
bash install-ros-packages.sh & wait $!
bash setup-anpl-mrbsp.sh --infrastructure=$PROJECT_NAME --branch=$BRANCH & wait $!

source_bashrc

# carkin belief:
bash install-libspdlog.sh --apt=false  & wait $! #(apt=false, from git) - mrbsp_utils wanted it
bash install-octomap.sh & wait $!	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it [sudo update and upgrade]
bash install-libccd.sh --apt=false  & wait $! #(AG need it - apt=false)
bash install-libfcl.sh --apt=true & wait $! #(AG need it - apt=true)
bash install-ompl.sh   --apt=true & wait $! #(AG need it, apt=true)
bash install-rosaria.sh & wait $!
bash install-find-cmakes.sh & wait $!

: <<'comment'
LINES_TO_BE_COMMENTED=('list(APPEND CMAKE_MODULE_PATH ${ANPL_PREFIX}/share/cmake)' 'set(OMPL_PREFIX ${ANPL_PREFIX})')
PATH_AG_CMAKE=~/ANPL/infrastructure/mrbsp_ws/src/anpl_mrbsp/action_generator/CMakeLists.txt
for line in "${LINES_TO_BE_COMMENTED[@]}"
do
	sed -i "s|${line}|#${line}|" $PATH_AG_CMAKE
done
comment

bash install-diverse-short-path.sh & wait $!	#(AG need it)
bash install-csm.sh --apt=false & wait $!	#(git=true)

LINES_TO_BE_COMMENTED=('#ifndef min' '#define min(a,b) ((a) < (b) ? (a) : (b))' '#endif' '#ifndef max' '#define max(a,b) ((a) > (b) ? (a) : (b))')
PATH_JSON_C_BITS=/usr/ANPLprefix/include/json-c/bits.h
for line in "${LINES_TO_BE_COMMENTED[@]}"
do
	sudo sed -i "s|${line}|//${line}|" $PATH_JSON_C_BITS
done
#sudo echo "#endif" >> $PATH_JSON_C_BITS
echo "#endif" | sudo tee -a $PATH_JSON_C_BITS

bash install-planar-icp.sh --branch=$PLANAR_BRANCH #(branch gtsam4)
sudo cp -r cmake /usr/ANPLprefix/share/

sudo apt-get install xterm graphiz-dev -y & wait $!

if [ -f "~/.ignition/fuel/config.yaml" ]; then 
	sed -i "s+https://api.ignitionfuel.org+https://api.ignitionrobotics.org+g" ~/.ignition/fuel/config.yaml
fi

cd ~/ANPL/infrastructure/mrbsp_ws/src/rosaria
sed -ie '/^#set(ROS_BUILD_TYPE RelWithDebInfo)/a add_compile_options(-std=c++11)' CMakeLists.txt
#catkin build rosaria

# mapper compilation requiers about 5G RAM on each core
# so we create additional swap space on disk.
cd ~/ANPL/infrastructure/mrbsp_ws/
sudo fallocate -l 10G /tmpswapfile
sudo chmod 600 /tmpswapfile
sudo mkswap /tmpswapfile
sudo swapon /tmpswapfile
# build
catkin build -j3
# and remove swap space
sudo swapoff -v /tmpswapfile
sudo rm /tmpswapfile

echo -e "\033[0;36m ++++  End of installation ++++    \033[0m"

