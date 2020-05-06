#!/bin/bash

echo "
export PATH=\$PATH:.:$(pwd)/src" >> ~/.bashrc
source ~/.bashrc

echo -e "\033[0;42mWelcome to ANPL's Multi-Robot Belief Space Planner open source installator!"
echo -e "Before installation please check if you have account @BitBucket and have full access to ANPL repository. If you don't please contact Vadim to get an access.\033[0m"
while true; do
    read -p "Do you wish to continue?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

chmod +r *
chmod +x *.py src/*



./src/install-showgitbranch.sh
# ./src/install-python.sh

# ROS installation and sourcing ".profile" to import ROS environment variables (ROS_DISTRO mainly)
./src/install-ros-kinetic.sh

if [ $ROS_DISTRO ="" ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 	echo "Rerun, ROS_DISTRO is empty"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	exec bash
fi

python3 main.py
