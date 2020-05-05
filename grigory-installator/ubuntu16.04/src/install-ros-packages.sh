#!/bin/bash
#ROS_DISTRO="kinetic"

sudo apt-get update
source ~/.bashrc

if [ $ROS_DISTRO ="" ]; then
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"    
 	echo "'${0##*/}' FAILED, ROS_DISTRO is empty"
	echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	read -p "Enter manually ROS_DISTRO (example 'kinetic') : " ROS_DISTRO
fi

sudo apt-get install python-catkin-tools -y
sudo apt-get install ros-$ROS_DISTRO-ecl -y
sudo apt-get install ros-$ROS_DISTRO-rviz-visual-tools -y

# install ROS master discovery and sync
sudo apt-get install ros-$ROS_DISTRO-master-discovery-fkie -y
sudo apt-get install ros-$ROS_DISTRO-master-sync-fkie -y

#install ROS hokuyo laser
sudo apt-get install ros-$ROS_DISTRO-urg-node -y

# Install ROS xacro
sudo apt-get install ros-$ROS_DISTRO-xacro -y

# Install ROS joint-state-publisher
sudo apt-get install ros-$ROS_DISTRO-joint-state-publisher -y

# Install ROS robot-state-publisher
sudo apt-get install ros-$ROS_DISTRO-robot-state-publisher -y

# Install ROS imu-sensor-controller
sudo apt-get install ros-$ROS_DISTRO-imu-sensor-controller -y

# Install ROS controller-manager
sudo apt-get install ros-$ROS_DISTRO-controller-manager -y

# Install ROS robot-localization
sudo apt-get install ros-$ROS_DISTRO-robot-localization -y

# Install ROS rviz-imu-pluggin (for debugging)
sudo apt-get install ros-$ROS_DISTRO-rviz-imu-plugin -y

# Install ROS image-geometry
sudo apt-get install ros-$ROS_DISTRO-image-geometry -y

# Install ROS opencv3
sudo apt-get install ros-$ROS_DISTRO-opencv3 -y

# Install ROS cv-bridge
sudo apt-get install ros-$ROS_DISTRO-cv-bridge -y

# Install ROS gazebo
#sudo apt-get install ros-$ROS_DISTRO-gazebo* -y
#for astra camera
cd ~/Downloads
wget https://raw.githubusercontent.com/orbbec/ros_astra_camera/master/56-orbbec-usb.rules
sudo mv 56-orbbec-usb.rules /etc/udev/rules.d/
sudo service udev reload
sudo service udev restart
