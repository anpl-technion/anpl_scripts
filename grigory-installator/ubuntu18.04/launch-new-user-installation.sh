#!/bin/bash

echo "export PATH=$PATH:$(pwd):$(pwd)/src" >> ~/.bashrc
source ~/.bashrc

echo -e "\033[0;36mWelcome to ANPL's Multi-Robot Belief Space Planner open source installator!"
echo "----------------------------------------------------------------------------------------"
echo -e "Before installation please check if you have account @BitBucket and have full access to ANPL repository."
echo -e "If you don't please contact Prof. Vadim to get an access.\033[0m"
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

# Installing boost1.58 to compile gtsam3.2.1 with;
 echo -e "\033[0;36mInstalling gcc5 before boost and gtsam! Please choose gcc5 as the primary compiler\033[0m"
 ./src/install-gcc5.sh
 ./gtsam3_boost1_58/install-boost1.58.sh
 ./gtsam3_boost1_58/install-gtsam.sh 
  echo -e "\033[0;36mIF BOOST and GTSAM build finished, go back to newer compiler(7)!\033[0m"
  sudo update-alternatives --config gcc

# ROS installation and sourcing ".profile" to import ROS environment variables (ROS_DISTRO mainly)
./src/install-ros-melodic.sh
. ~/.bashrc
. ~/.profile
source /opt/ros/melodic/setup.bash

read -p "Continue only if boost,gtsam and melodic are ERRORS FREE (y/n)" yn
case $yn in
        [Yy]* ) python3 main.py;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac

