#!/bin/bash



echo -e "\033[0;36mWelcome to ANPL's Multi-Robot Belief Space Planner open source installator!"
echo -e "Before installation please check if you have account @BitBucket and have full access to ANPL repository. If you don't please contact Vadim to get an access.\033[0m"
while true; do
    read -p "Do you wish to continue?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

cd src/
echo "export PATH=$PATH:$(pwd)" >> ~/.bashrc
source ~/.bashrc


bash install-ros-melodic.sh
bash install-gtsam4.sh
source ~/.bashrc
sleep 2
echo "ROS_DISTRO = " $ROS_DISTRO
bash install-ros-packages.sh 
bash setup-anpl-mrbsp.sh

# carkin belief:
bash install-libspdlog.sh #(apt=false, from git) - mrbsp_utils wanted it
bash install-octomap.sh 	#(apt ros-melodic-octomap) - mrbsp_msgs wanted it [sudo update and upgrade]
bash install-libccd.sh 	#(AG need it - apt=false)
bash install-libfcl.sh 	#(AG need it - apt=false)
bash install-ompl.sh   	#(AG need it, apt=true)
LINES_TO_BE_COMMENTED=('list(APPEND CMAKE_MODULE_PATH ${ANPL_PREFIX}/share/cmake)' 'set(OMPL_PREFIX ${ANPL_PREFIX})')
PATH_AG_CMAKE=~/ANPL/infrastructure/mrbsp_ws/src/anpl_mrbsp/action_generator/CMakeLists.txt
for line in "${LINES_TO_BE_COMMENTED[@]}"
do
	sed -i "s|${line}|#${line}|" $PATH_AG_CMAKE
done

bash install-diverse-short-path.sh 	#(AG need it)
bash install-csm.sh 					#(git=true)
LINES_TO_BE_COMMENTED=('#ifndef min' '#define min(a,b) ((a) < (b) ? (a) : (b))' '#endif' '#ifndef max' '#define max(a,b) ((a) > (b) ? (a) : (b))')
PATH_JSON_C_BITS=/usr/ANPLprefix/include/json-c/bits.h
for line in "${LINES_TO_BE_COMMENTED[@]}"
do
	sudo sed -i "s|${line}|//${line}|" $PATH_JSON_C_BITS
done
#sudo echo "#endif" >> $PATH_JSON_C_BITS
echo "#endif" | sudo tee -a $PATH_JSON_C_BITS

bash install-planar-icp.sh  #(brasnch gtsam4)
sudo mkdir -p /usr/ANPLprefix/share/cmake
cd cmake/
sudo cp FindIt.cmake /usr/ANPLprefix/share/cmake/

sudo apt-get install xterm

if [ -f "~/.ignition/fuel/config.yaml" ]; then 
	sed -i "s+https://api.ignitionfuel.org+https://api.ignitionrobotics.org+g" ~/.ignition/fuel/config.yaml
fi

echo -e "\033[0;36m ++++  End of installation ++++    \033[0m"

